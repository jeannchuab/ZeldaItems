//
//  Category.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 23/09/22.
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
