//
//  Constants.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 26.02.2024.
//

struct Constants {
    
    struct Network {
        static let petApiBaseURL = "https://api.petfinder.com"
        static let animalsURL = "/v2/animals"
        static let oAuthTokenURL = "/v2/oauth2/token"
        static let timeoutInterval: Double = 19
        static let animalsPage = "?page="
        
        struct Headers {
            static let authorization = "Authorization"
            static let bearer = "Bearer "
            static let contentType = "Content-Type"
            static let application_json = "application/json"
        }
        
        struct Parameters {
            static let grantType = "grant_type"
            static let clientCredentials = "client_credentials"
            static let clientID = "client_id"
            static let clientSecret = "client_secret"
        }
    }
    
    struct Keychain {
        static let serviceName = "Pets"
        static let accessToken = "access_token"
        
    }
    
    struct UserInterface {
        struct Cells {
            static let petDetailsCollectionViewCell = "PetDetailsCollectionViewCell"
            static let petListTableViewCell = "PetListTableViewCell"
        }
        
        struct Layer {
            static let petDetailsContentViewRadius: Double = 20
            static let petImageViewRadius: Double = 65
            static let activityIndicatorHeight: Double = 100
        }
        
        struct Images {
            static let petsPlaceholder = "petsPlaceholder"
        }
        
        struct Alert {
            static let alertTitle = "Meow.. Got tangled in the cables again 😿"
            static let okayAction = "No worries catto"
        }
        
        struct Error {
            static let oAuthTokenFailed = "Couldn't get the token"
        }
    }
}
