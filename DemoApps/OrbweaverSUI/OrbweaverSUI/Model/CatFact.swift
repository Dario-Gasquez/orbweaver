//
//  CatFact.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Foundation

struct CatFact: Decodable {
    let fact: String
    let length: Int
}


extension CatFact: CustomDebugStringConvertible {
    var debugDescription: String {
        let debugString =
        """

        - CatFact -------------------------------------
        fact: \(fact)
        length: \(length)
        -----------------------------------------------

        """

        return debugString
    }
}
