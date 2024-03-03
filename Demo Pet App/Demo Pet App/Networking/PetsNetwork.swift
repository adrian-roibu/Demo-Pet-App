//
//  PetsNetwork.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 26.02.2024.
//

import Foundation
import Alamofire

typealias ResultCompletion<T> = (Swift.Result<T?, Error>) -> Void

protocol PetsNetworkService {
    func getPetsList(paginationHref: String?, completion: ResultCompletion<Pets>?)
    func fetchAccessToken(completion: @escaping (Bool) -> Void)
}

private struct NetworkKeys {
    static let client_id = "8FvB92COL3loJkRHBozGPLOVKZTG4CgXal6Dou6EjsH5lj2SXB"
    static let client_secret = "zcYSA3CrhG6yW1dc539o8rAVgj7ecwLUaYHTSe3s"
}

class PetsNetwork: PetsNetworkService {
    
    static let sharedInstance = PetsNetwork()
    
    let session: NetworkSessionManager
    
    let tokenManager = AccessTokenManager.sharedInstance
    
    init() {
        self.session = NetworkSessionManager.createSession()
    }
    
    func getPetsList(paginationHref: String? = nil, completion: ResultCompletion<Pets>?) {
        
        //"https://api.petfinder.com/v2/animals"
        var url =  Constants.Network.petApiBaseURL + Constants.Network.animalsURL
        
        if let href = paginationHref {
            url = Constants.Network.petApiBaseURL + href
        }
        
        let headers: HTTPHeaders = [
            Constants.Network.Headers.authorization: Constants.Network.Headers.bearer + (tokenManager.getToken() ?? "")
        ]
        
        session.request(url,
                        method: .get,
                        encoding: JSONEncoding.prettyPrinted,
                        headers: headers)
        .validate()
        .responseDecodable(of: Pets.self) { (response) in
            switch response.result {
            case .success:
                guard let data = response.value else { return }
                
                completion?(.success(data))
            case .failure:
                guard let error = response.error else { return }
                completion?(.failure(error))
            }
        }
    }
    
    func fetchAccessToken(completion: @escaping (Bool) -> Void) {
        
        let url = Constants.Network.petApiBaseURL + Constants.Network.oAuthTokenURL
        
        let headers: HTTPHeaders = [
            Constants.Network.Headers.contentType: Constants.Network.Headers.application_json
        ]
        
        let parameters = [
            Constants.Network.Parameters.grantType : Constants.Network.Parameters.clientCredentials,
            Constants.Network.Parameters.clientID: NetworkKeys.client_id,
            Constants.Network.Parameters.clientSecret: NetworkKeys.client_secret
        ]
        
        session.request(url,
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.prettyPrinted,
                        headers: headers)
        .responseDecodable(of: AccessToken.self) { response in
            guard let token = response.value else {
                return completion(false)
            }
            
            AccessTokenManager.sharedInstance.saveAccessToken(with: token)
            
            completion(true)
        }
    }
}
