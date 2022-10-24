//
//  RequestConfig.swift
//  Orbweaver
//
//  Created by Dario on 4/15/19.
//

import Foundation

public enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}


public struct RequestConfig {
    public typealias APIKeyPair = (clientID: String, clientSecret: String)

    public init(apiHost: String, queryParameters: [URLQueryItem]? = nil, customHeaders: [String: String]? = nil, authenticationToken: String? = nil, apiKeyPair: APIKeyPair? = nil) {
        self.apiHost = apiHost
        self.queryParameters = queryParameters
        self.apiKeyPair = apiKeyPair
        self.authenticationToken = authenticationToken
        self.customHeaders = customHeaders
    }

    public let apiHost: String
    public let queryParameters: [URLQueryItem]?

    public var httpHeaders: [String: String] {
        var headers = [String: String]()

        if let apiKey = apiKeyPair {
            headers[Constants.clientIDHeaderFieldKey] = apiKey.clientID
            headers[Constants.clientSecretHeaderFieldKey] = apiKey.clientSecret
        }

        if let token = authenticationToken {
            headers[Constants.authenticationHeaderFieldKey] = token
        }

        if let extraHeaders = customHeaders {
            headers.merge(extraHeaders) { _, second in
                second
            }
        }

        return headers
    }

    // MARK: - Private Section -
    private let authenticationToken: String?
    private let apiKeyPair: APIKeyPair? // FIXME: We should not have a clientSecret inside the app. Instead use more secure solutions like OAuth2 with proof key flow (PKCE)
    private let customHeaders: [String: String]?

    private enum Constants {
        static let clientIDHeaderFieldKey = "clientid"
        static let clientSecretHeaderFieldKey = "clientsecret"
        static let authenticationHeaderFieldKey = "Authorization"
    }
}
