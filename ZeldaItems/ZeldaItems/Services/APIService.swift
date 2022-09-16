//
//  APIService.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import Foundation

class APIService {
    
    private let apiURL = "https://botw-compendium.herokuapp.com/api/v2/category/"
    
    func getCategoryItems(_ type: Category, completion: @escaping ([CategoryItem], Error?) -> Void) {        
        get(type.rawValue) { data, error in
            guard let jsonData = data else {
                completion([], error)
                return
            }
                                    
            do {
                if let jsonList = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    print("Log:", jsonList)
                                                                                
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([String:[CategoryItem]].self, from: jsonData)
                    
                    completion(decoded["data"] ?? [], error)
                } else {
                    completion([], error)
                }
            } catch let error {
                completion([], error)
            }
        }
    }
    
    func get(_ domain: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let api = URL(string: "\(apiURL)\(domain)") else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            completion(data, nil)
        }
        
        task.resume()
    }
}
