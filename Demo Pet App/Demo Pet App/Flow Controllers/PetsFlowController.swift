//
//  PetsFlowController.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 24.02.2024.
//

import UIKit

protocol MainFlowController {
    var navigationController: UINavigationController { get }
    
    init(navigationController: UINavigationController)
    
    func start()
    func presentPetDetailsViewController(with data: Pet)
    func showAlert(with message: String, completion: (() -> Void)?)
}

class PetsFlowController: MainFlowController {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.viewModel = HomeViewModel(petsNetworkService: PetsNetwork.sharedInstance)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentPetDetailsViewController(with data: Pet) {
        let vc = PetDetailsViewController()
        vc.viewModel = PetDetailsViewModel(data: data)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlert(with message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: Constants.UserInterface.Alert.alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.UserInterface.Alert.okayAction, style: .default, handler: { _ in
            completion?()
        })
        
        alert.addAction(action)
        navigationController.present(alert, animated: true)
    }
}
