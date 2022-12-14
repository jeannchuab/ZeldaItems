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
            return "๐ฆ Creatures"
        case .equipment:
            return "๐น Equipment"
        case .materials:
            return "๐งช Materials"
        case .monsters:
            return "๐น Monsters"
        case .treasure:
            return "๐ Treasure"
        }
    }
    
    init(title: String) {
        switch title {
        case "๐ฆ Creatures":
            self = Category.creatures
        case "๐น Equipment":
            self = Category.equipment
        case "๐งช Materials":
            self = Category.materials
        case "๐น Monsters":
            self = Category.monsters
        case "๐ Treasure":
            self = Category.treasure
        default:
            self = Category.creatures
        }
    }
}
