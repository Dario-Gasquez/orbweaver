//
//  QueueManager.swift
//  Orbweaver
//
//  Created by Dario on 4/15/19.
//

import Foundation

public class QueueManager {

    public static func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }

    // MARK: - Private Section -
    private static let queue = OperationQueue()

}
