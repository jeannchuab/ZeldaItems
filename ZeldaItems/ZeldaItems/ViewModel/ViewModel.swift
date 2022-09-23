//
//  ViewModel.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation
import UIKit

protocol ViewModelProtocol: AnyObject {
    func selectCategory(_ category: String)
    func fetch()
    func search(text: String?)
    func downloadImage(with imageUrlString: String?, completion: @escaping (UIImage) -> Void)
    func getSelectedCategoryItemFormated() -> CategoryItemFormated?
    func getCategoryItemFormated(_ item: CategoryItem) -> CategoryItemFormated?
    func selectListItem(item: CategoryItem)
}

protocol ViewModelHomeDelegate: AnyObject {
    func showError()
}

protocol ViewModelListItemDelegate: AnyObject {
    func showError()
    func updateItems(_ category: Category, listCategoriesItems: [CategoryItem])
}

class ViewModel: ViewModelProtocol {
    weak var delegateListItems: ViewModelListItemDelegate?
    private var apiService: APIService
    
    private var categoryItems: [CategoryItem] = []
    var category: Category = Category.creatures
    var selectedCategoryItem: CategoryItem?
    var imageDownloader: ImageDownloader
    
    init(apiService: APIService = APIService(), imageDownloader: ImageDownloader = ImageDownloader.shared ) {
        self.apiService = apiService
        self.imageDownloader = imageDownloader
    }
    
    func fetch() {
        apiService.getCategoryItems(self.category) { array, error in
            if array.isEmpty || error != nil {
                self.delegateListItems?.showError()
            } else {
                self.categoryItems = array.sorted(by: { $0.name ?? "" < $1.name ?? "" })
                self.delegateListItems?.updateItems(self.category, listCategoriesItems: self.categoryItems)
            }
            
        }
    }
    
    func search(text: String?) {
        guard let text = text, !text.isEmpty
        else {
            self.delegateListItems?.updateItems(category, listCategoriesItems: categoryItems)
            return
        }
        
        self.delegateListItems?.updateItems(category, listCategoriesItems: categoryItems.filter({ $0.name?.uppercased().contains(text.uppercased()) ?? false }))
    }
    
    func downloadImage(with imageUrlString: String?,
                       completion: @escaping (UIImage) -> Void) {
     
        imageDownloader.downloadImage(with: imageUrlString, completionHandler: { image, _ in
            
            guard let image = image else {
                completion(UIImage.init(systemName: "gamecontroller") ?? UIImage())
                return
            }
            
            completion(image)
            
        }, placeholderImage: UIImage.init(systemName: "gamecontroller") ?? UIImage())
        
    }
    
    func getSelectedCategoryItemFormated() -> CategoryItemFormated? {
        guard let item = selectedCategoryItem else { return nil }
        return getCategoryItemFormated(item)
    }
    
    func getCategoryItemFormated(_ item: CategoryItem) -> CategoryItemFormated? {
        var locationsFormated = ""        
        for item in item.commonLocations ?? [] {
            if locationsFormated.isEmpty {
                locationsFormated = "\("Locations: ")\(item)"
            } else {
                locationsFormated = "\(locationsFormated), \(item)"
            }
        }
        
        let categoryItemFormated = CategoryItemFormated(category: Category(rawValue: item.category ?? "")?.getTitle(),
                                                commonLocations: locationsFormated,
                                                description: item.description,
                                                image: item.image,
                                                name: item.name?.capitalized)
        
        return categoryItemFormated
    }
    
    func selectCategory(_ category: String) {
        self.category = Category.init(title: category)
    }
    
    func selectListItem(item: CategoryItem) {
        self.selectedCategoryItem = item
    }
}
