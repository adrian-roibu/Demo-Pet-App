//
//  HomeViewModelTests.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 02.03.2024.
//

import XCTest
import Alamofire
import RxSwift
@testable import Demo_Pet_App

final class HomeViewModelTests: XCTestCase {
    
    private var mockService: MockNetworkService!
    private var sut: HomeViewModel!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        mockService = MockNetworkService()
        sut = HomeViewModel(petsNetworkService: mockService)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_get_pets() {
        
        let expectation = XCTestExpectation(description: "Test mock fetch success")
        
        sut.pets.asObservable()
            .subscribe(onNext: { pets in
                if let pets = pets {
                    XCTAssertNotNil(pets)
                    XCTAssert(!pets.animals.isEmpty)
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        sut.retrievePetList()

        // Make sure the right service gets called
        XCTAssert(mockService.isGetPetsListCalled)
        
        mockService.fetchPetListSuccess()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_get_pets_fail() {
        // Not authorized error
        let expectedError = NSError(domain: "Mock", code: 401)
        
        let expectation = XCTestExpectation(description: "Test mock fetch failure")
        
        sut.error.asObservable()
            .subscribe(onNext: { error in
                XCTAssertEqual(error, expectedError.localizedDescription)
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        sut.retrievePetList()
        
        XCTAssertEqual(sut.isLoading, true)
        
        mockService.fetchPetListFail(error: expectedError)
        
        wait(for: [expectation], timeout: 0.1)
    }
}
