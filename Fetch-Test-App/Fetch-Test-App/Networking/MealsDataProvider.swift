//
//  MealsDataProvider.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation

protocol MealDataProvidable {
    func fetchAllMeals() async throws -> [Meal]
    func searchMeals(with query: String) async throws -> [Meal]
    func getMeal(with id: String) async throws -> Meal
}

class MealsDataProvider: MealDataProvidable {
    
    private let endpoint: MealsEndpoint
    
    init(endpoint: MealsEndpoint) {
        self.endpoint = endpoint
    }
    
    func fetchAllMeals() async throws -> [Meal] {
        guard let url = URL(string: endpoint.baseURLString + endpoint.allDesertsPath) else {
            throw MealsError.invalidEndpoint
        }
        
        let result: MealsDataResponse = try await self.load(from: url)
        
        let meals: [Meal] = result.meals.map { Meal(from: $0) }
        
        return meals
    }
    
    func searchMeals(with query: String) async throws -> [Meal] {
        guard let url = URL(string: endpoint.baseURLString + endpoint.mealsSearchPath(with: query)) else {
            throw MealsError.invalidEndpoint
        }
        
        let result: MealsDataResponse = try await self.load(from: url)
        
        let meals: [Meal] = result.meals.map { Meal(from: $0) }
        
        return meals
    }
    
    func getMeal(with id: String) async throws -> Meal {
        guard let url = URL(string: endpoint.baseURLString + endpoint.mealPath(with: id)) else {
            throw MealsError.invalidEndpoint
        }
        
        print(url.absoluteString)
        
        let result: MealsDataResponse = try await self.load(from: url)
        
        guard let meal: Meal = result.meals.map({ Meal(from: $0) }).first else {
            throw MealsError.noData
        }
        
        return meal
    }
}

extension MealsDataProvider {
    func load<D: Decodable>(from url: URL) async throws -> D {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            print("Error Response: \(response)")
            throw MealsError.invalidResponse
        }
        
        return try JSONDecoder().decode(D.self, from: data)
    }
}
