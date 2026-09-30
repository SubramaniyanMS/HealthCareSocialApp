//
//  APIError.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    case noData
    case unauthorized
    case noToken

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpError(let code):
            return "Server error (HTTP \(code))."
        case .decodingError(let error):
            return "Data parsing error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .noData:
            return "No data received."
        case .unauthorized:
            return "Session expired. Please log in again."
        case .noToken:
            return "Authentication token unavailable."
        }
    }
}
