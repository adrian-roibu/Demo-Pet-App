//
//  NetworkSessionManager.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 26.02.2024.
//

import Alamofire

class NetworkSessionManager: Session {
    
    private class func configuration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.af.default
        
        configuration.timeoutIntervalForRequest = Constants.Network.timeoutInterval
        configuration.timeoutIntervalForRequest = Constants.Network.timeoutInterval
        configuration.waitsForConnectivity = true
        
        return configuration
    }
    
    // certificate pinning
    
    
}

extension NetworkSessionManager {
    class func createSession() -> NetworkSessionManager {
        let session = NetworkSessionManager(configuration: configuration())
        return session
    }
}
