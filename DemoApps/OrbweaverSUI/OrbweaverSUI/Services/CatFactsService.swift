//
//  CatFactsService.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Combine
import Orbweaver

/// Provides the following services:
/// - Retrieve cat facts data.
/// - Create a `CatFactsViewModel` from the retrieved cat facts data.

final class CatFactsService: ObservableObject {

    @Published private(set) var catFactsViewModel = CatFactsViewModel()


    func fetchCatFactsData() {
        guard let catFactsURLRequest = catFactsRequestFactory.catFactsRequest(limit: Constants.numberOfFactsToRetrieve) else {
            assertionFailure("Unable to obtain a cat facts URLRequest from the factory")
            return
        }

        let reactiveOperation = ReactiveOperation<CatFactsResponse>()

        reactiveOperation.obtainPublisher(urlRequest: catFactsURLRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let apiError):
                    print("Error retrieving cat facts data: \(apiError)")
                }
            }, receiveValue: { [weak self] catFacts in
                print("===== received cat facts response ==========")
                print(catFacts)

                self?.catFactsViewModel = CatFactsViewModel(from: catFacts)
            })
            .store(in: &subscriptions)
    }

    // MARK: - Private Section -
    private enum Constants {
        static let numberOfFactsToRetrieve = 10
    }

    private let catFactsRequestFactory = CatFactsURLRequestFactory()

    private var subscriptions = Set<AnyCancellable>()
}
