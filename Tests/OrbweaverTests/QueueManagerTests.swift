//
//  QueueManagerTests.swift
//  OrbweaverTests
//
//  Created by Dario on 11/29/19.
//

import XCTest
@testable import Orbweaver


class QueueManagerTests: XCTestCase {
    private class ConcurrentOperationMock: ConcurrentOperation<StubResponse> {
        override func main() {

            guard let testData = retrieveTestData(for: self, from: "StubResponseData", fileExtension: "json") else {
                self.complete(result: .failure(APIError.invalidData))
                return
            }

            guard let expectedStubResponse = try? JSONDecoder().decode(StubResponse.self, from: testData) else {
                self.complete(result: .failure(APIError.serializationFailed))
                return
            }

            self.complete(result: .success(expectedStubResponse))
        }
    }


    func test_operationAddedToQueue_isCompletedSuccessfully() {
        // given
        let promise = XCTestExpectation(description: "operation finished successfully")
        let operation = ConcurrentOperationMock()

        operation.completionHandler = { result in
            switch result {
            case .success:
                promise.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        // when
        QueueManager.enqueue(operation)

        // then
        wait(for: [promise], timeout: 1)
    }
}
