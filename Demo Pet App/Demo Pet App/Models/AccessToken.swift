//
//  AccessToken.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 26.02.2024.
//

import Foundation

struct AccessToken: Codable {
    let token_type: String
    let expires_in: Int
    let access_token: String
}
