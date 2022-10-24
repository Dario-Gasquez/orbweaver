//
//  URLProtocolMock.swift
//  OrbweaverTests
//
//  Created by Dario on 3/24/20.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testData: Data?
    static var response: URLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }


    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }


    override func startLoading() {
        if let data = URLProtocolMock.testData {
            self.client?.urlProtocol(self, didLoad: data)
        }

        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }


    // This method has to be defined but at the moment we have no use for it, that is why we have an empty implementation
    override func stopLoading() {}
}
