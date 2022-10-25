//
//  ContentView.swift
//  OrbweaverSUI
//
//  Created by Dario on 24/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text(catFactsService.catFactsViewModel.title)
                .font(.title)
                .padding()
            Text(catFactsService.catFactsViewModel.subtitle)
                .font(.subheadline)
                .padding()
            List(catFactsService.catFactsViewModel.facts) { catFact in
                factRow(with: catFact.fact, length: catFact.length)
            }
        }
        .onAppear {
            catFactsService.fetchCatFactsData()
        }
    }


    // MARK: - Private Section -
    @StateObject private var catFactsService = CatFactsService()

    private func factRow(with fact: String, length: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("fact: \(fact)")
            Text("length: \(length)")
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
