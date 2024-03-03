//
//  FlowControllerMock.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import UIKit

final class FlowControllerMock: MainFlowController {
    internal var navigationController: UINavigationController
    var didStart = false
    var pushPetDetailsCalled = false
    var presentAlertControllerCalled = false
    var presentPetDetailsCounter = 0
    var showAlertCounter = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        didStart = true
    }
    
    func presentPetDetailsViewController(with data: Pet) {
        let vc = PetDetailsViewController()
        vc.viewModel = PetDetailsViewModel(data: data)
        navigationController.pushViewController(vc, animated: true)
        
        pushPetDetailsCalled = true
        presentPetDetailsCounter += 1
    }
    
    func showAlert(with message: String, completion: (() -> Void)?) {
        presentAlertControllerCalled = true
        showAlertCounter += 1
    }
}
