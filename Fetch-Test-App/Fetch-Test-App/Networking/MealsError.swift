//
//  MealsError.swift
//  Fetch-Test-App
//
//  Created by Kevin Hartley on 9/18/24.
//

import Foundation

enum MealsError: Error {
    case invalidResponse
    case invalidEndpoint
    case noData
    case serializationError
}
