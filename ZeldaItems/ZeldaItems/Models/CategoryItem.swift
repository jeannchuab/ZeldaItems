//
//  Creature.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation

class CategoryItem: Codable {
    var category: String?
    var commonLocations: [String]?
    var description: String?
    var id: Int
    var image: String?
    var name: String?
        
    enum CodingKeys: String, CodingKey {
        case category
        case commonLocations = "common_locations"
        case description
        case id
        case image
        case name
    }
}
