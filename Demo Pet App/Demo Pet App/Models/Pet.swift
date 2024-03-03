//
//  Pet.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 26.02.2024.
//

struct Pet: Decodable {
    let id: Int
    let type: String
    let species: String
    let breeds: Breeds?
    let colors: Colors?
    let age: String
    let gender: String
    let size: String
    let coat: String?
    let tags: [String]
    let name: String
    let description: String?
    let photos: [Photo]?
    let status: String
    let published_at: String
    let distance: Double?
    let contact: Contact?
}
