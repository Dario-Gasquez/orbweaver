//
//  TestUtilities.swift
//  OrbweaverTests
//
//  Created by Dario on 3/23/20.
//

import Foundation

func retrieveTestData(for object: AnyObject, from filename: String, fileExtension: String) -> Data? {
    guard let url = Bundle.module.url(forResource: filename, withExtension: fileExtension) else {
        return nil
    }

    guard let data = try? Data(contentsOf: url) else {
        return nil
    }

    return data
}
