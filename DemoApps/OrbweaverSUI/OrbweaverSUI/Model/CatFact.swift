//
//  CatFact.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Foundation

struct CatFact: Decodable, Identifiable {
    let id: UUID
    let fact: String
    let length: Int

    enum CodingKeys: String, CodingKey {
        case fact
        case length
    }
}


// MARK: - Decodable
extension CatFact {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        fact = try container.decode(String.self, forKey: .fact)
        length = try container.decode(Int.self, forKey: .length)
    }
}


// MARK: - CustomDebugStringConvertible
extension CatFact: CustomDebugStringConvertible {
    var debugDescription: String {
        let debugString =
        """

        - CatFact -------------------------------------
        fact: \(fact)
        length: \(length)
        id: \(id)
        -----------------------------------------------

        """

        return debugString
    }
}
