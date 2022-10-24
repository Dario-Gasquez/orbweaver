//
//  NSMutableData+Extensions.swift
//  Orbweaver
//
//  Created by Dario on 16/08/2022.
//

import Foundation

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
