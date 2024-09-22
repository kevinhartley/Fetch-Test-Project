//
//  MealDetailsView.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation
import SwiftUI

struct MealDetailsView: View {
    
    @ObservedObject var viewModel: MealDetailsViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: viewModel.meal?.thumbnailURLString ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "fork.knife.circle")
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        default:
                            ProgressView()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding([.bottom], 20)
                    .padding([.leading, .trailing], 7)
                    
                    Group {
                        VStack {
                            Text(viewModel.meal?.name ?? "No Meal Name")
                                .font(.title2)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                        }
                        .padding(10)
                    }
                    .frame(alignment: .bottomLeading)
                    .background(
                        Rectangle()
                            .fill(Color.sand)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 7)
                    )
                    .padding([.leading, .trailing], 15)
                }
                
                MealDetailsPillCollection(
                    details: (
                        id: viewModel.meal?.id,
                        origin: viewModel.meal?.origin,
                        link: viewModel.meal?.videoLinkURLString)
                    , parentWidth: proxy.size.width
                )
                
                VStack(alignment: .leading) {
                    if let ingredients = viewModel.meal?.ingredients, !ingredients.isEmpty {
                        Text("Ingredients:")
                            .font(.title)
                            .bold()
                        ForEach(ingredients, id: \.self) {
                            Text($0.name)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Text($0.amount)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black.opacity(0.4), lineWidth: 1)
                )
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 5)
                
                VStack(alignment: .leading) {
                    Text("Instructions:")
                        .font(.title)
                        .bold()
                    Text(viewModel.meal?.instructions ?? "No Instructions Available")
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black.opacity(0.4), lineWidth: 1)
                )
                .padding([.leading, .trailing])
            }
            .onAppear(perform: {
                viewModel.getMeal(with: viewModel.mealID)
            })
            .navigationTitle(viewModel.meal?.category ?? "No Category")
            .background(Color.sand)
            .toolbarBackground(Color.sand, for: .navigationBar)
        }
    }
}
