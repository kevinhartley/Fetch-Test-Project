//
//  MealCell.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation
import SwiftUI

struct MealCell: View {
    
    let meal: Meal
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: meal.thumbnailURLString)) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "fork.knife.circle")
                        .font(.largeTitle)
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                default:
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10
                )
            )
            .frame(width: 110, height: 80)
            
            Text(meal.name)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
        .background(Color.sand)
    }
}
