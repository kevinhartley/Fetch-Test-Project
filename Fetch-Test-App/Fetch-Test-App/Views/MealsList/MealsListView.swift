//
//  ContentView.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import SwiftUI

struct MealsListView: View {
    
    @StateObject var viewModel: MealsListViewModel
    @State private var headerText = "All Results"
    @State var detailPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Section(
                    header: Text(headerText)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                ) {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    } else if viewModel.mealResults.isEmpty {
                        if viewModel.searchText.isEmpty {
                            if !viewModel.isLoading {
                                Text("Unable to retrive Meals")
                            }
                        } else {
                            Text("No Meals match this search")
                        }
                    } else {
                        ForEach(viewModel.mealResults, id: \.self) { meal in
                            NavigationLink(
                                destination: MealDetailsView(
                                    viewModel: MealDetailsViewModel(
                                        with: MealsDataProvider(
                                            endpoint: MealsAPI()
                                        ),
                                        mealID: meal.id
                                    )
                                )
                            )
                            {
                                MealCell(meal: meal)
                                    .cornerRadius(14)
                                    .shadow(radius: 14)
                                    .frame(height: 110)
                            }
                        }
                    }
                }
                .padding()
                .textCase(nil)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.sand)
            .toolbar(detailPresented ? .hidden : .visible, for: .tabBar)
            .toolbarBackground(Color.sand, for: .navigationBar)
            .navigationTitle("Meals")
            .navigationBarTitleDisplayMode(.large)
            .refreshable(action: {
                viewModel.fetchAllMeals()
            })
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchText, initial: true) { _, newText  in
                if newText.isEmpty {
                    headerText = "All Results"
                    viewModel.fetchAllMeals()
                } else {
                    headerText = "Search Results"
                    viewModel.searchMeals(with: newText)
                }
            }
        }
    }
}

#Preview {
    MealsListView(viewModel: MealsListViewModel(with: MealsDataProvider(endpoint: MealsAPI())))
}
