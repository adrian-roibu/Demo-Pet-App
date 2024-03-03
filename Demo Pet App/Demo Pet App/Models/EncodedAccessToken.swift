//
//  EncodedAccessToken.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 02.03.2024.
//

import Foundation

struct EncodedAccessToken: Codable {
    let accessToken: AccessToken
    let savedDate: Date
}
