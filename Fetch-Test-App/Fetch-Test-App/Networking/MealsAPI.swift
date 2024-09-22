//
//  MealsAPI.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation

protocol MealsEndpoint {
    var apiKey: String { get }
    var baseURLString: String { get }
    var allDesertsPath: String { get }
    func mealsSearchPath(with query: String) -> String
    func mealPath(with id: String) -> String
}

struct MealsAPI: MealsEndpoint {
    var apiKey: String = "1"
    
    var baseURLString: String {
        "https://www.themealdb.com/api/json/v1/1"
    }

    var allDesertsPath: String {
        "/filter.php?c=Dessert"
    }
    
    func mealsSearchPath(with query: String) -> String {
        "/search.php?s=\(query)"
    }
    
    func mealPath(with id: String) -> String {
        "/lookup.php?i=\(id)"
    }
}
