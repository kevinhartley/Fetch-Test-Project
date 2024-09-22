//
//  MealResponse.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation

struct MealsDataResponse: Codable, Hashable {
    let meals: [MealResponse]
}

struct MealResponse: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strYoutube: String?
    var strIngredient: [String]?
    var strMeasure: [String]?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
        case strCategory
        case strArea
        case strInstructions
        case strYoutube
        case strIngredient
        case strMeasure
    }
    
    struct AnyKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
    
    struct IngredientNameCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.stringValue = "strIngredient\(intValue)"
        }
    }
    
    struct IngredientAmountCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.stringValue = "strMeasure\(intValue)"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyKey.self)
        
        if let meal = AnyKey(stringValue: CodingKeys.strMeal.rawValue) {
            strMeal = try container.decode(String.self, forKey: meal)
        } else {
            strMeal = "No Meal"
        }
        
        if let thumbnail = AnyKey(stringValue: CodingKeys.strMealThumb.rawValue) {
            strMealThumb = try container.decode(String.self, forKey: thumbnail)
        } else {
            strMealThumb = "No Thumbnail"
        }
        
        if let id = AnyKey(stringValue: CodingKeys.idMeal.rawValue) {
            idMeal = try container.decode(String.self, forKey: id)
        } else {
            idMeal = "No ID"
        }
        
        if let category = AnyKey(stringValue: CodingKeys.strCategory.rawValue) {
            strCategory = try container.decodeIfPresent(String.self, forKey: category)
        } else {
            strCategory = nil
        }
        
        if let area = AnyKey(stringValue: CodingKeys.strArea.rawValue) {
            strArea = try container.decodeIfPresent(String.self, forKey: area)
        } else {
            strArea = nil
        }
        
        if let instructions = AnyKey(stringValue: CodingKeys.strInstructions.rawValue) {
            strInstructions = try container.decodeIfPresent(String.self, forKey: instructions)
        } else {
            strInstructions = nil
        }
        
        if let youtubeLink = AnyKey(stringValue: CodingKeys.strYoutube.rawValue) {
            strYoutube = try container.decodeIfPresent(String.self, forKey: youtubeLink)
        } else {
            strYoutube = nil
        }

        strIngredient = try (1...20).compactMap {
            if let ingredientKey = IngredientNameCodingKeys(intValue: $0)?.stringValue,
            let ingredient = AnyKey(stringValue: ingredientKey) {
                return try container.decodeIfPresent(String.self, forKey: ingredient)
            } else {
                return nil
            }
        }
        
        strMeasure = try (1...20).compactMap {
            if let amountKey = IngredientAmountCodingKeys(intValue: $0)?.stringValue,
            let amount = AnyKey(stringValue: amountKey) {
                return try container.decodeIfPresent(String.self, forKey: amount)
            } else {
                return nil
            }
        }
    }
    
}
