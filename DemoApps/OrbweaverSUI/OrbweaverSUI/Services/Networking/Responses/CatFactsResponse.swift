//
//  CatFactsResponse.swift
//  OrbweaverSUI
//
//  Created by Dario on 25/10/2022.
//

import Foundation

/*
---------------
Description:
---------------
The structures decoded from the answer received from the /facts/random endpoint.

---------------
Documentation
---------------
 https://catfact.ninja

--------------------
endpoint URL
--------------------
 https://catfact.ninja/facts
*/


struct CatFactsResponse: Decodable {
    let data: [CatFact]
}


extension CatFactsResponse: CustomDebugStringConvertible {
    var debugDescription: String {
        let debugString =
        """

        = CatFactsResponse ===================================
        Total number items: \(data.count)
        data: \(data)
        ======================================================

        """

        return debugString
    }
}
