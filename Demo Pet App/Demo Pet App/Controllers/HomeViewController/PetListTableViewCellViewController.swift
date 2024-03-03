//
//  PetListTableViewCellViewController.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 03.03.2024.
//

import Foundation

struct PetListTableViewCellViewModel {
    let name: String
    let age: String
    let gender: String
    let location: String
    let imageUrl: URL?
    
    init(pet: Pet) {
        self.name = pet.name
        self.age = pet.age
        self.gender = pet.gender
        self.location = pet.contact?.address?.fullAddress ?? ""
        self.imageUrl = pet.photos?.first?.fullURL ?? nil
    }
}
