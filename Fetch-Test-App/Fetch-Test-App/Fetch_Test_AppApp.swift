//
//  Fetch_Test_App.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import SwiftUI

@main
struct Fetch_Test_App: App {
    
    @ObservedObject var viewModel = MealsListViewModel(with: MealsDataProvider(endpoint: MealsAPI()))
    
    var body: some Scene {
        WindowGroup {
            MealsListView(viewModel: viewModel)
        }
    }
}
