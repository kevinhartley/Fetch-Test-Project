//
//  Meal.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation

struct Meal: Hashable { 
    let id: String
    let name: String
    let thumbnailURLString: String
    let category: String?
    let origin: String?
    let instructions: String?
    let videoLinkURLString: String?
    let ingredients: [Ingredient]?
    
    init(from mealResponse: MealResponse) {
        self.id = mealResponse.idMeal
        self.name = mealResponse.strMeal
        self.thumbnailURLString = mealResponse.strMealThumb
        self.category = mealResponse.strCategory
        self.origin = mealResponse.strArea
        self.instructions = mealResponse.strInstructions
        self.videoLinkURLString = mealResponse.strYoutube
        self.ingredients = Meal.buildIngredients(ingredientNames: mealResponse.strIngredient, ingredientAmounts: mealResponse.strMeasure)
    }
    
    static func buildIngredients(ingredientNames: [String]?, ingredientAmounts: [String]?) -> [Ingredient] {
        var ingredients: [Ingredient] = []
        
        guard let ingredientNames = ingredientNames else { return ingredients }
        guard let ingredientAmounts = ingredientAmounts else { return ingredients }
        
        for (index, name) in ingredientNames.enumerated() {
            let amount = ingredientAmounts[index]
            if !amount.isEmpty {
                let validIngredient = Ingredient(name: name, amount: amount)
                ingredients.append(validIngredient)
            }
        }
        
        return ingredients
    }
}

struct Ingredient: Hashable {
    let name: String
    let amount: String
}
