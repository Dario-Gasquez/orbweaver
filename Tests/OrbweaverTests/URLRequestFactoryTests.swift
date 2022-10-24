//
//  URLRequestFactoryTests.swift
//  OrbweaverTests
//
//  Created by Dario on 10/23/19.
//

import XCTest
@testable import Orbweaver

class URLRequestFactoryTests: XCTestCase {
    let cid = "br2z2xepudarExu6e5edr3wa"
    let secret = "wrawab3spanat2udrufratHa"
    let etsAPIHost = "http://dev.goldenspear.com/ets"
    lazy var etsURL = URL(string: etsAPIHost)!

    func test_initWithAPIKeyPar_returnsExpectedHTTPHeaders() {
        // Given
        let keyPair: RequestConfig.APIKeyPair = (clientID: cid, clientSecret: secret)
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: keyPair)
        let urlRequestFactory = URLRequestFactory(config: requestConfig)

        // When
        guard let jsonURLRequest = urlRequestFactory.jsonRequest(endPoint: "addEvent", httpMethod: HTTPRequestMethod.post),
            let allHeaders = jsonURLRequest.allHTTPHeaderFields else {
                XCTFail("Expected not nil URL Request")
                return
        }

        // Then
        XCTAssertEqual(allHeaders["Content-Type"], "application/json")
        XCTAssertEqual(allHeaders["clientid"], cid)
        XCTAssertEqual(allHeaders["clientsecret"], secret)
    }


    func test_initWithoutAPIKeyPair_returnsNilHTTPHeaders() {
        // Given
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: nil)
        let urlRequestFactory = URLRequestFactory(config: requestConfig)

        // When
        guard let jsonURLRequest = urlRequestFactory.jsonRequest(endPoint: "addEvent", httpMethod: HTTPRequestMethod.post), let allHeaders = jsonURLRequest.allHTTPHeaderFields else {
            XCTFail("Expected not nil URL Request")
            return
        }

        // Then
        XCTAssertNil(allHeaders["clientid"], "Expected nil clientid header")
        XCTAssertNil(allHeaders["clientsecret"], "Expected nil clientsecret header")
    }


    func test_initWithAuthToken_returnsExpectedHTTPHeader() {
        // Given
        let authToken = "Basic aW50ZXJmYWNlczptbFhDXkhYIyRKOTNlQ0E="
        let requestConfig = RequestConfig(apiHost: etsAPIHost, authenticationToken: authToken)
        let urlRequestFactory = URLRequestFactory(config: requestConfig)

        // When
        guard let jsonURLRequest = urlRequestFactory.jsonRequest(endPoint: "addEvent", httpMethod: HTTPRequestMethod.post),
            let allHeaders = jsonURLRequest.allHTTPHeaderFields else {
                XCTFail("Expected not nil URL Request")
                return
        }

        // Then
        XCTAssertEqual(allHeaders["Content-Type"], "application/json")
        XCTAssertEqual(allHeaders["Authorization"], authToken)
        XCTAssertNil(allHeaders["clientid"], "Expected nil clientid header")
        XCTAssertNil(allHeaders["clientsecret"], "Expected nil clientid header")
    }


    func test_initWitQueryParameters_generatesAValidURLRequest() {
        // Given
        let searchEndpoint = "search"

        let userIDQueryItem = URLQueryItem(name: "userID", value: "5e57ff0c8a7725000134c8e2")
        let searchStringQueryItem = URLQueryItem(name: "query", value: "red shoes")
        let queryItems: [URLQueryItem] = [
            userIDQueryItem,
            searchStringQueryItem
        ]
        var urlComponents = URLComponents(url: etsURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems

        let requestConfig = RequestConfig(apiHost: etsAPIHost, queryParameters: queryItems)
        let urlRequestFactory = URLRequestFactory(config: requestConfig)

        // When
        guard let jsonURLRequest = urlRequestFactory.jsonRequest(endPoint: searchEndpoint, httpMethod: HTTPRequestMethod.post) else {
            XCTFail("Expected not nil URL Request")
            return
        }

        guard let expectedURLComponents = urlComponents else {
            XCTFail("Expected not nil URLComponents")
            return
        }

        // Then
        XCTAssertEqual(jsonURLRequest.httpMethod, HTTPRequestMethod.post.rawValue)
        XCTAssertEqual(jsonURLRequest.url?.scheme, expectedURLComponents.scheme)
        XCTAssertEqual(jsonURLRequest.url?.host, expectedURLComponents.host)
        XCTAssertEqual(jsonURLRequest.url?.path, "\(expectedURLComponents.path)/\(searchEndpoint)")
        XCTAssertEqual(jsonURLRequest.url?.query, expectedURLComponents.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }


    func test_jsonRequest_generatesExpectedURLRequest() {
        // Given
        let addEventEndPoint = "addEvent"
        let keyPair: RequestConfig.APIKeyPair = (clientID: cid, clientSecret: secret)
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: keyPair)
        let urlRequestFactory = URLRequestFactory(config: requestConfig)

        // When
        guard let jsonURLRequest = urlRequestFactory.jsonRequest(endPoint: addEventEndPoint, httpMethod: HTTPRequestMethod.post) else {
            XCTFail("Expected not nil URL Request")
            return
        }

        // Then
        XCTAssertEqual(jsonURLRequest.httpMethod, HTTPRequestMethod.post.rawValue)
        XCTAssertEqual(jsonURLRequest.url?.scheme, etsURL.scheme)
        XCTAssertEqual(jsonURLRequest.url?.host, etsURL.host)
        XCTAssertEqual(jsonURLRequest.url?.path, "\(etsURL.path)/\(addEventEndPoint)")
    }
}
