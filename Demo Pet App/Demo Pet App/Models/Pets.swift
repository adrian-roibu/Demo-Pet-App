//
//  Pets.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

struct Pets: Decodable {
    let animals: [Pet]
    let pagination: Pagination
}
