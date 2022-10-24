//
//  ReactiveOperation.swift
//  Orbweaver
//
//  Created by Dario on 30/06/2022.
//

import Combine
import Foundation

open class ReactiveOperation<T: Decodable> {

    public init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }

    open func obtainPublisher(urlRequest: URLRequest) -> AnyPublisher<T, APIError> {
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw self.handleHTTPErrorStatusCode(httpResponse.statusCode, data: data)
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                self.handleError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Section -
    private let session: URLSession

    private func handleHTTPErrorStatusCode(_ statusCode: Int, data: Data) -> APIError {
        switch statusCode {
        case 400: return .badRequest(additionalData: data)
        case 401: return .unauthorized(additionalData: data)
        case 404: return .notFound(additionalData: data)
        case 422: return .unprocessableEntity(additionalData: data)
        case 402, 405...499: return .clientError(errorDescription: "unknown client error. statusCode = \(statusCode)")
        case 500...599: return .serverError
        default: return .unknown
        }
    }

    private func handleError(_ error: Error) -> APIError {
        switch error {
        case is Swift.DecodingError: return .serializationFailed
        case let urlError as URLError: return .urlSessionError(errorDescription: urlError.localizedDescription)
        case let error as APIError: return error
        default: return .unknown
        }
    }
}
