//
//  FlowControllerTests.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import XCTest

final class FlowControllerTests: XCTestCase {

    private var sut: FlowControllerMock!
    private var mockNavigationController: NavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        
        mockNavigationController = NavigationControllerMock()
        sut = FlowControllerMock(navigationController: mockNavigationController)
    }
    
    override  func tearDown() {
        sut = nil
        mockNavigationController = nil
        
        super.tearDown()
    }
    
    func testStart() {
        sut.start()
        
        XCTAssert(sut.didStart)
    }
    
    func testAlertCalled() {
        sut.showAlert(with: Constants.UserInterface.Alert.alertTitle, completion: nil)
        
        XCTAssertTrue(sut.presentAlertControllerCalled)
    }
    
    func testPetDetailsScreenCalled() {
        let petJson = Bundle.main.url(forResource: "Pet", withExtension: "json")
        let data = try! Data(contentsOf: petJson!)
        
        let pet = try! JSONDecoder().decode(Pet.self, from: data)
        
        sut.presentPetDetailsViewController(with: pet)
        
        XCTAssertTrue(sut.pushPetDetailsCalled)
    }
}
