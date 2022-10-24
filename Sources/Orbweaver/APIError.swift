//
//  APIError.swift
//  Orbweaver
//
//  Created by Dario on 01/07/2022.
//

import Foundation

public enum APIError: Error, Equatable {
    case unknown
    /// No data received from the server.
    case missingData
    /// Unable to parse/translate/deserialized the received data
    case serializationFailed
    case invalidData
    /// A  server error. For example an HTTP Response status code in the range: 400-499
    case clientError(errorDescription: String)
    /// A  server error. For example an HTTP Response status code in the range: 500-599
    case serverError
    /// The received response does not have the expected format.
    case invalidResponse
    /// Maps errors returned by the the URL loading APIs (URLError)
    case urlSessionError(errorDescription: String)
    case badRequest(additionalData: Data)           // HTTP Status code: 400
    case unauthorized(additionalData: Data)         // HTTP Status code: 401
    case forbidden                                  // HTTP Status code: 403
    case notFound(additionalData: Data)             // HTTP Status code: 404
    case unprocessableEntity(additionalData: Data)  // HTTP Status code: 422
}


extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .clientError(let description):
            return description
        case .unknown:
            return "Unknown error"
        case .missingData:
            return "Missing data"
        case .serializationFailed:
            return "Unable to serialize the data"
        case .invalidData:
            return "Received data is invalid"
        case .serverError:
            return "Server error"
        case .invalidResponse:
            return "Response format is invalid"
        case .urlSessionError(let description):
            return  "URL Session error: \(description)"
        case .badRequest:
            return "Bad request"
        case .unauthorized:
            return "Request was not authorized"
        case .forbidden:
            return "The resource is forbidden"
        case .notFound:
            return "The requested resource was not found"
        case .unprocessableEntity:
            return "The request could not be processed"
        }
    }
}
