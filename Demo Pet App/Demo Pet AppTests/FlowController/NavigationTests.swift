//
//  NavigationTests.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import XCTest
import RxSwift

final class NavigationTests: XCTestCase {
    private var sut: HomeViewController!
    private var mockFlowController: FlowControllerMock!
    private var mockNavigationController: NavigationControllerMock!
    private var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        
        mockNavigationController = NavigationControllerMock()
        mockFlowController = FlowControllerMock(navigationController: mockNavigationController)
        mockService = MockNetworkService()
        sut = HomeViewController()
        sut.coordinator = mockFlowController
        sut.viewModel = HomeViewModel(petsNetworkService: mockService)
        
    }
    
    override  func tearDown() {
        sut = nil
        mockNavigationController = nil
        mockFlowController = nil
        mockService = nil
        
        super.tearDown()
    }
    
    func testShowDetailsScreen() {
        sut.viewModel.retrievePetList()
        
        mockService.fetchPetListSuccess()
        
        sut.presentPetDetails(at: IndexPath(row: 0, section: 0))
        
        XCTAssert(mockFlowController.pushPetDetailsCalled)
        XCTAssert(mockNavigationController.pushViewControllerCalled)
        XCTAssertNotNil(mockFlowController.navigationController.viewControllers.last as! PetDetailsViewController)
        
    }
    
    func testPetDetailsScreenHasData() {
        sut.viewModel.retrievePetList()
        
        mockService.fetchPetListSuccess()
        
        sut.presentPetDetails(at: IndexPath(row: 0, section: 0))
        
        guard let petDetailsViewController = mockFlowController.navigationController.viewControllers.last as? PetDetailsViewController else {
            return XCTFail("Couldn't cast to PetDetailsViewController, check view controller's hierachy")
        }
        
        XCTAssertNotNil(petDetailsViewController.viewModel.pet)
    }
}
