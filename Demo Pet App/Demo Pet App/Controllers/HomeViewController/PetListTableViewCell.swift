//
//  PetListTableViewCell.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 28.02.2024.
//

import UIKit
import SDWebImage

class PetListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    
    var viewModel: PetListTableViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    private func bindViewModel() {
        if let viewModel = viewModel {
            nameLabel.text = viewModel.name
            ageLabel.text = viewModel.age
            genderLabel.text = viewModel.gender
            locationLabel.text = viewModel.location
            petImageView.sd_setImage(with: viewModel.imageUrl, placeholderImage: UIImage(named: Constants.UserInterface.Images.petsPlaceholder))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        petImageView.layer.cornerRadius = Constants.UserInterface.Layer.petImageViewRadius
    }
}
