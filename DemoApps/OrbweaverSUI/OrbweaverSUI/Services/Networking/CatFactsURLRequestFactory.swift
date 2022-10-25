//
//  CatFactsURLRequestFactory.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Foundation
import Orbweaver

final class CatFactsURLRequestFactory: URLRequestFactory {

    init() {
        let requestConfig = RequestConfig(apiHost: RemoteHosts.defaultHost)
        super.init(config: requestConfig)
    }


    func catFactsRequest(limit: Int) -> URLRequest? {
        assert(1...20 ~= limit , "amount out of valid range")

        guard var catFactsURLRequest = jsonRequest(endPoint: CatFactsEndpoints.randomFacts, httpMethod: .get), let catFactsURL = catFactsURLRequest.url else {
            assertionFailure("Failed to obtain a valid cat facts URLRequest")
            return nil
        }

        guard var urlComponents = URLComponents(url: catFactsURL, resolvingAgainstBaseURL: true) else {
            assertionFailure("Unable to generate a valid cat facts URLComponents")
            return nil
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]

        catFactsURLRequest.url = urlComponents.url

        return catFactsURLRequest
    }


    // MARK: - Private Section -
    private enum CatFactsEndpoints {
        static let randomFacts = "facts"
    }
}
