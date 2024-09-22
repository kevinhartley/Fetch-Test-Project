//
//  MealDetailsViewModel.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation
import SwiftUI

@MainActor
class MealDetailsViewModel: ObservableObject {
    
    @Published var meal: Meal?
    @State var isLoading: Bool = false
    let mealID: String
    
    private var mealDataProvider: MealDataProvidable
    
    init(with mealDataProvider: MealDataProvidable, mealID: String) {
        self.mealDataProvider = mealDataProvider
        self.mealID = mealID
    }
    
    func getMeal(with mealID: String) {
        Task {
            do {
                let meal = try await mealDataProvider.getMeal(with: mealID)
                self.meal = meal
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
