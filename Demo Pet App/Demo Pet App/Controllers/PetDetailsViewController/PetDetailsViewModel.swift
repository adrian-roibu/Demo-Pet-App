//
//  PetDetailsViewModel.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

import Foundation
import UIKit

class PetDetailsViewModel {
    
    var pet: Pet
    
    init(data: Pet) {
        self.pet = data
    }
    
    func numberOfItemsInSection() -> Int {
        guard let photosArray = pet.photos else { return 1 }
        
        // If there are no pictures for the animal, create one placeholder cell
        return photosArray.count == 0 ? 1 : photosArray.count
    }
    
    func setup(cell: PetDetailsCollectionViewCell, at indexPath: IndexPath) {
        // If there are no pictures for the animal, set a placeholder image
        if pet.photos?.count == 0 {
            cell.petPhotoImageView.image = UIImage(named: Constants.UserInterface.Images.petsPlaceholder)
        } else {
            cell.petPhotoImageView.sd_setImage(with: pet.photos?[indexPath.row].fullURL, placeholderImage: UIImage(named: Constants.UserInterface.Images.petsPlaceholder))
        }
    }
}
