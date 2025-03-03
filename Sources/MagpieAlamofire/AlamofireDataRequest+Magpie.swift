// Copyright © 2020 hipolabs. All rights reserved.

import Alamofire
import Foundation
import MagpieCore

/**
 The conformance of `TaskConvertible` protocol by `Alamofire.DataRequest`type.
 The instances of `DataRequest` will be saved to a stash for the ongoing tasks. Then, the library
 can access these instances and operates on them easily.
 */

/// <mark>
/// **DataRequest**

/// <mark>
/// **TaskConvertible**
extension Alamofire.DataRequest: TaskConvertible {
    /// Returns the identifier of the active task, or -1.
    public var taskIdentifier: Int {
        return task?.taskIdentifier ?? -1
    }

    /// Returns whether the active task is ongoing or not, or false.
    public var inProgress: Bool {
        return
            isInitialized ||
            isResumed ||
            isSuspended
    }

    /// Cancels the active task immediatelty.
    public func cancelNow() {
        cancel()
    }
}

/// <mark>
/// **CustomDebugStringConvertible**
extension Alamofire.DataRequest {
    public var debugDescription: String {
        return description
    }
}

extension Alamofire.DataRequest {
    /// <warning>
    /// The default response serializer interprets a small set of http status codes with
    /// an empty response body as successful requests.
    func magpie_responseData(in queue: DispatchQueue, completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataResponseSerializer(emptyResponseCodes: Set(200..<300)), completionHandler: completionHandler)
    }
}

/// <mark>
/// **DownloadRequest**

/// <mark>
/// **TaskConvertible**
extension Alamofire.DownloadRequest: TaskConvertible {
    public var taskIdentifier: Int {
        return task?.taskIdentifier ?? -1
    }

    public var inProgress: Bool {
        return
            isInitialized ||
            isResumed ||
            isSuspended
    }

    public func cancelNow() {
        cancel()
    }
}

/// <mark>
/// **CustomDebugStringConvertible**
extension Alamofire.DownloadRequest {
    public var debugDescription: String {
        return description
    }
}

extension Alamofire.DownloadRequest {
    func magpie_responseURL(in queue: DispatchQueue, completionHandler: @escaping (AFDownloadResponse<URL>) -> Void) -> Self {
        return responseURL(queue: queue, completionHandler: completionHandler)
    }
}
