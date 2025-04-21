//
//  Network Manager.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//
import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let reachabilityManager = NetworkReachabilityManager()

    func isConnectedToInternet() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }

    func startMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("No connection")
            case .reachable(_):
                print("Connected")
            case .unknown:
                print("Unknown network status")
            }
        })
    }
}
