//
//  NavigationControllerMock.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import UIKit

// Navigation controller spy 🥷🏻
final class NavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    var presentCalled = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        presentCalled = true
    }
}
