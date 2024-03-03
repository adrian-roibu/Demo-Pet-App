//
//  AccessTokenManager.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

import SimpleKeychain

final class AccessTokenManager {
    
    static let sharedInstance = AccessTokenManager()
    
    private let keychain = SimpleKeychain(service: Constants.Keychain.serviceName)
    private var accessToken: AccessToken?
    
    init() {
        retrieveAccessTokenFromKeychain()
    }
    
    func saveAccessToken(with token: AccessToken) {
        accessToken = token
        let encodedToken = EncodedAccessToken(accessToken: token, savedDate: Date())
        
        do {
            let encoded = try JSONEncoder().encode(encodedToken)
            
            try keychain.set(encoded, forKey: Constants.Keychain.accessToken)
        } catch {
            // TO DO: - Handle this, log to Dynatrace or Firebase
            print(error)
        }
    }
    
    func retrieveAccessTokenFromKeychain() {
        do {
            let codedToken = try keychain.string(forKey: Constants.Keychain.accessToken)
            let decodedToken = try JSONDecoder().decode(EncodedAccessToken.self, from: Data(codedToken.utf8))
            
            if Int(Date().timeIntervalSince(decodedToken.savedDate)) < decodedToken.accessToken.expires_in {
                accessToken = decodedToken.accessToken
            } else {
                try keychain.deleteItem(forKey: Constants.Keychain.accessToken)
            }

        } catch {
            // TO DO: - Handle this, log to Dynatrace or Firebase
            print(error)
        }
    }
    
    // MARK: - Helpers
    
    func isTokenValid() -> Bool {
        if accessToken != nil {
            return true
        } else {
            return false
        }
    }
    
    func getToken() -> String? {
        return accessToken?.access_token
    }
}
