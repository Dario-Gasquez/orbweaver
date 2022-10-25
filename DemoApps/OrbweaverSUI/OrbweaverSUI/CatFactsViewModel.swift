//
//  CatFactsViewModel.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Foundation

struct CatFactsViewModel {
    let title = "Cat Facts"

    var subtitle: String {
        return "\(facts.count) cat facts"
    }

    private(set) var facts = [CatFact]()

    init(from catFacts: CatFactsResponse) {
        self.facts = catFacts.data
    }

    init() {
        self.facts = []
    }
}
