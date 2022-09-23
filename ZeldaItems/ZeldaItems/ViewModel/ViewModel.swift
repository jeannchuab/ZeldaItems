//
//  ViewModel.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation
import UIKit

protocol ViewModelProtocol: AnyObject {
    func fetch(type: String)
}

protocol ViewModelDelegate: AnyObject {
    func showCategoryItems(_ category: Category)
    func showError()
}

class ViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    private var apiService: APIService
    
    var categoryItems: [CategoryItem] = []
    var category: Category = Category.creatures
    var selectedCategoryItem: CategoryItem?
    var imageDownloader: ImageDownloader
    
    init(delegate: ViewModelDelegate, apiService: APIService = APIService(), imageDownloader: ImageDownloader = ImageDownloader.shared ) {
        self.delegate = delegate
        self.apiService = apiService
        self.imageDownloader = imageDownloader
    }
    
    func fetch(type: String) {
        category = Category.init(title: type)
        
        apiService.getCategoryItems(category) { categoryItems, error in
            if categoryItems.isEmpty {
                self.delegate?.showError()
            } else {
                self.categoryItems = categoryItems
                self.delegate?.showCategoryItems(self.category)
            }
        }
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
        guard let commonLocations = item.commonLocations else { return nil }
        
        var locationsFormated = ""        
        for item in commonLocations {
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
    
    func selectItem(item: CategoryItem) {
        self.selectedCategoryItem = item
    }
}
