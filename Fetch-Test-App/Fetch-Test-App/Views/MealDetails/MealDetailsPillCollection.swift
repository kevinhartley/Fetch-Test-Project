//
//  MealDetailsPillCollection.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/22/24.
//

import Foundation
import SwiftUI

struct MealDetailsPillCollection: View {
    var details: (id: String?, origin: String?, link: String?)
    var parentWidth: CGFloat
    
    var body: some View {
        Group {
            Group {
                HStack(alignment: .top) {
                    Spacer()
                    VStack {
                        Text("ID")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(details.id ?? "No ID Available")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .shadow(radius: 3)
                        .frame(width: 1)
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Text("Origin")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        Text(details.origin ?? "No Origin Available")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .shadow(radius: 3)
                        .frame(width: 1)
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Text("Link")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                        if let url = details.link {
                            let link = "[Watch Video](\(url))"
                            Text(.init(link))
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("No Link Available")
                        }
                    }
                    Spacer()
                }
                .padding([.top, .bottom])
            }
            .background(
                Rectangle()
                    .fill(Color.sand)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 7)
            )
            .padding([.leading, .trailing])
        }
        .frame(minWidth: parentWidth)
    }
}
