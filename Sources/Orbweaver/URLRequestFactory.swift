//
//  URLRequestFactory.swift
//  Orbweaver
//
//  Created by Dario on 4/15/19.
//

import Foundation


open class URLRequestFactory {

    public init(config: RequestConfig) {
        self.config = config
    }

    open func jsonRequest(endPoint: String, httpMethod: HTTPRequestMethod) -> URLRequest? {
        guard var request = baseRequest(endPoint: endPoint) else {
            return nil
        }

        request.httpMethod = httpMethod.rawValue

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let headers = config.httpHeaders
        if !headers.isEmpty {
            request.allHTTPHeaderFields = headers
        }

        return request
    }

    // MARK: - Private Section -
    private let config: RequestConfig

    private func baseRequest(endPoint: String) -> URLRequest? {
        let stringURL = "\(config.apiHost)/\(endPoint)"

        guard let encodedStringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            var urlComponents = URLComponents(string: encodedStringURL) else {
                return nil
        }

        if let queryParamaters = config.queryParameters {
            urlComponents.queryItems = queryParamaters
        }

        guard let url = urlComponents.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}
