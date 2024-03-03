//
//  Address.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

struct Address: Decodable {
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let postcode: String?
    let country: String
    
    var fullAddress: String {
        return [city, state].joined(separator: ", ")
    }
}
