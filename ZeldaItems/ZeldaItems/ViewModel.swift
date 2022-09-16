//
//  ViewModel.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation

enum Categories: String, CaseIterable {
    case creatures
    case equipment
    case materials
    case monsters
    case treasure
    
//    func getTitle() {
//        switch self {
//        case .creatures: return ""
//        }
//    }
    
    
    init(title: String) {
        switch title {
        case "🦄 Creatures":
            self = Categories.creatures
        case "🏹 Equipment":
            self = Categories.equipment
        case "🧪 Materials":
            self = Categories.materials
        case "🧌 Monsters":
            self = Categories.monsters
        case "💎 Treasure":
            self = Categories.treasure
        default:
            self = Categories.creatures
        }
    }
}

protocol ViewModelProtocol: AnyObject {
    func fetch(type: String)
}

protocol ViewModelDelegate: AnyObject {
    func showCategoryItems()
    func showError()
//    func showCreatures() -> [CategoryItem]
//    func showEquipment() -> [CategoryItem]
//    func showMasterials() -> [CategoryItem]
//    func showMonsters() -> [CategoryItem]
//    func showTreasure() -> [CategoryItem]
}

class ViewModel: ViewModelProtocol {
    
    weak var delegate: ViewModelDelegate?
    var apiService: APIService
    
    var categoryItems: [CategoryItem] = []
//    var equipment = []
//    var materials = []
//    var monsters = []
//    var treasure = []
    
    init(delegate: ViewModelDelegate, apiService: APIService = APIService()) {
        self.delegate = delegate
        self.apiService = apiService
    }
    
    func fetch(type: String) {
        let categorie = Categories.init(title: type)
        
        apiService.getCategoryItems(categorie) { categoryItems, error in
            if categoryItems.isEmpty {
                self.delegate?.showError()
            } else {
                self.categoryItems = categoryItems
                self.delegate?.showCategoryItems()
            }
        }
    }
}
