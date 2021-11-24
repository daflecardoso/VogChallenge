//
//  APIProvider.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import Moya

class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    private let enabledMock = ProcessInfo.processInfo.arguments.contains("UITest")
    private let logEnabled: Bool = true
    
    init(stub: Bool = false) {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let plugin = NetworkLoggerPlugin(configuration: configuration)
        let plugins: [PluginType] = [plugin]
        let networkLogger: [PluginType] = self.logEnabled ? plugins : []
        if self.enabledMock || stub {
            super.init(stubClosure: MoyaProvider.delayedStub(1),
                       plugins: networkLogger)
        } else {
            super.init(plugins: networkLogger)
        }
    }
    
    static var headers: [String: String] {
        return [
            "Accept-Language": Locale.current.languageCode ?? "en",
            "Authorization": "Bearer \(KeyChainCache.shared.token())",
            "Content-Type": "application/json"
        ]
    }
}
