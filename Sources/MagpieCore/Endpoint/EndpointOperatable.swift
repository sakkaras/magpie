//
//  EndpointOperatable.swift
//  Pods
//
//  Created by Salih Karasuluoglu on 13.09.2018.
//

import Foundation
import MacaroonUtils

public protocol EndpointOperatable: Printable {
    var type: EndpointType { get }
    var request: Request { get }
    var isFinished: Bool { get }

    func setAdditionalHeader(_ header: Header, policy: AdditionalHeaderPolicy)

    @discardableResult
    func send() -> EndpointOperatable
    func retry()
    func cancel()
}

extension EndpointOperatable {
    public func setAdditionalHeader(_ header: Header) {
        setAdditionalHeader(
            header,
            policy: .alwaysOverride
        )
    }
}

public enum AdditionalHeaderPolicy {
    case alwaysOverride
    case setIfNotExists
}

extension Optional where Wrapped == EndpointOperatable {
    public var isNilOrFinished: Bool {
        switch self {
        case .none: return true
        case .some(let some): return some.isFinished
        }
    }
}
