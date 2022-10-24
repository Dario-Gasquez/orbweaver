//
//  RequestConfigTests.swift
//  OrbweaverTests
//
//  Created by Dario on 10/22/19.
//

import XCTest
@testable import Orbweaver

class RequestConfigTests: XCTestCase {
    let cid = "br2z2xepudarExu6e5edr3wa"
    let secret = "wrawab3spanat2udrufratHa"
    let etsAPIHost = "http://dev.goldenspear.com/ets"
    let authenticationToken = "Basic aW50ZXJmYWNlczptbFhDXkhYIyRKOTNlQ0E="

    func test_initWithNilAPIKeyPair_returnsNilHTTPHeaders() {
        // Given
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: nil)

        // When
        let httpHeaders = requestConfig.httpHeaders

        // Then
        XCTAssertTrue(httpHeaders.isEmpty, "expected emtpy HTTPHeaders when no API Key pair provided")
    }


    func test_initWithAPIKeyPair_returnsValidHTTPHeaders() {
        // Given
        let keyPair: RequestConfig.APIKeyPair = (clientID: cid, clientSecret: secret)
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: keyPair)

        // When
        let httpHeaders = requestConfig.httpHeaders
        guard !httpHeaders.isEmpty else {
            XCTFail("expected not empty HTTPHeaders when valid API Key pair provided")
            return
        }

        // Then
        XCTAssertEqual(httpHeaders["clientid"], cid)
        XCTAssertEqual(httpHeaders["clientsecret"], secret)
    }


    func test_initWithValidAPIHost_returnsExpectedAPIHost() {
        // Given
        let keyPair: RequestConfig.APIKeyPair = (clientID: cid, clientSecret: secret)
        let requestConfig = RequestConfig(apiHost: etsAPIHost, apiKeyPair: keyPair)

        // When
        let apiHost = requestConfig.apiHost

        // Then
        XCTAssertEqual(apiHost, etsAPIHost)
    }


    func test_initWithQueryParamters_returnsExpectedQueryString() {
        // Given
        let userIDQueryItem = URLQueryItem(name: "userID", value: "5e57ff0c8a7725000134c8e2")
        let searchStringQueryItem = URLQueryItem(name: "query", value: "red shoes")
        let queryItems: [URLQueryItem] = [
            userIDQueryItem,
            searchStringQueryItem
        ]

        let requestConfig = RequestConfig(apiHost: etsAPIHost, queryParameters: queryItems)

        // When
        guard let queryParameters = requestConfig.queryParameters else {
            XCTFail("expected not nil URLQueryItems")
            return
        }

        // Then
        XCTAssertEqual(queryParameters[0].name, userIDQueryItem.name)
        XCTAssertEqual(queryParameters[0].value, userIDQueryItem.value)
        XCTAssertEqual(queryParameters[1].name, searchStringQueryItem.name)
        XCTAssertEqual(queryParameters[1].value, searchStringQueryItem.value)
    }


    func test_initWithAuthenticationToken_returnsExpectedHTTPHeader() {
        // Given
        let requestConfig = RequestConfig(apiHost: etsAPIHost, authenticationToken: authenticationToken)

        // When
        let httpHeaders = requestConfig.httpHeaders
        guard !httpHeaders.isEmpty else {
            XCTFail("expected not empty HTTPHeaders when valid API Key pair provided")
            return
        }

        // Then
        XCTAssertEqual(httpHeaders["Authorization"], authenticationToken)
    }


    func test_initWithCustomAPIKeyHeader_returnsExpectedHTTPHeader() {
        // Given
        let apiKeyName = "x-api-key"
        let apiKeyValue = "vFfrD62RE6vjnYo62bXAIscNBtupqbTsJxvVrPjY20THYbpQUX1An3LLoRKxSn6P"
        let requestConfig = RequestConfig(apiHost: etsAPIHost, customHeaders: [apiKeyName: apiKeyValue])

        // When
        let httpHeaders = requestConfig.httpHeaders
        guard !httpHeaders.isEmpty else {
            XCTFail("expected not empty HTTPHeaders when valid API Key pair provided")
            return
        }

        // Then
        XCTAssertEqual(httpHeaders[apiKeyName], apiKeyValue)
    }
}
