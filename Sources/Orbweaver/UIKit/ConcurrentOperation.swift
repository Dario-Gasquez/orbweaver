//
//  ConcurrentOperation.swift
//  Orbweaver
//
//  Created by Dario on 4/15/19.
//

import Foundation

open class ConcurrentOperation<T>: Operation {
    public typealias OperationCompletionHandler = (_ result: Result<T, Error>) -> Void

    public var completionHandler: (OperationCompletionHandler)?

    open override var isReady: Bool {
        return super.isReady && state == .ready
    }

    open override var isExecuting: Bool {
        return state == .executing
    }

    open override var isFinished: Bool {
        return state == .finished
    }

    open override func start() {
        guard !isCancelled else {
            finish()
            return
        }

        if !isExecuting {
            state = .executing
        }

        main()
    }

    open override func cancel() {
        super.cancel()
        finish()
    }

    public func finish() {
        if isExecuting {
            state = .finished
        }
    }

    public func complete(result: Result<T, Error>) {
        finish()

        if !isCancelled {
            completionHandler?(result)
        }
    }


    // MARK: - Private Section -

    private enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }

    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            willChangeValue(forKey: oldValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
    }
}
