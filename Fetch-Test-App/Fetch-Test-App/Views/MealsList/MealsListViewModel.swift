//
//  MealsListViewModel.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation
import SwiftUI

@MainActor
class MealsListViewModel: ObservableObject {
    
    @Published var mealResults: [Meal] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private var mealDataProvider: MealDataProvidable
    
    init(with mealDataProvider: MealDataProvidable) {
        self.mealDataProvider = mealDataProvider
    }
    
    func searchMeals(with query: String) {
        Task {
            do {
                let meals = try await mealDataProvider.searchMeals(with: query)
                self.mealResults = meals
            } catch {
                guard let mealsError = error as? MealsError else {
                    print("UnknownError: \(error)")
                    return
                }
                print("Underlying Issue: \(mealsError)")
                return
            }
        }
    }
    
    func fetchAllMeals() {
        Task {
            do {
                let meals = try await mealDataProvider.fetchAllMeals()
                self.mealResults = meals
            } catch {
                guard let mealsError = error as? MealsError else {
                    print("UnknownError: \(error)")
                    return
                }
                print("Underlying Issue: \(mealsError)")
                return
            }
        }
    }
}
