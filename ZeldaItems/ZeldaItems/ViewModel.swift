//
//  ViewModel.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation

enum Category: String, CaseIterable {
    case creatures
    case equipment
    case materials
    case monsters
    case treasure
    
    func getTitle() -> String {
        switch self {
        case .creatures:
            return "🦄 Creatures"
        case .equipment:
            return "🏹 Equipment"
        case .materials:
            return "🧪 Materials"
        case .monsters:
            return "👹 Monsters"
        case .treasure:
            return "💎 Treasure"
        }
    }
    
    init(title: String) {
        switch title {
        case "🦄 Creatures":
            self = Category.creatures
        case "🏹 Equipment":
            self = Category.equipment
        case "🧪 Materials":
            self = Category.materials
        case "👹 Monsters":
            self = Category.monsters
        case "💎 Treasure":
            self = Category.treasure
        default:
            self = Category.creatures
        }
    }
}

protocol ViewModelProtocol: AnyObject {
    func fetch(type: String)
}

protocol ViewModelDelegate: AnyObject {
    func showCategoryItems(_ category: Category)
    func showError()
}

class ViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    var apiService: APIService    
    var categoryItems: [CategoryItem] = []
    var category: Category = Category.creatures
    var selectedCategoryItem: CategoryItem?
    
    init(delegate: ViewModelDelegate, apiService: APIService = APIService()) {
        self.delegate = delegate
        self.apiService = apiService
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
    
    func selectItem(item: CategoryItem) {
        self.selectedCategoryItem = item
    }
}
