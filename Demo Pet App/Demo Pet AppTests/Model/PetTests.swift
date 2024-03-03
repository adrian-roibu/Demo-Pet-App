//
//  PetTests.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import XCTest

final class PetTests: XCTestCase {
    func testSuccessfulInit() {
        let petJson = Bundle.main.url(forResource: "Pet", withExtension: "json")
        let data = try! Data(contentsOf: petJson!)
        
        let petList = try! JSONDecoder().decode(Pet.self, from: data)
        
        XCTAssertNotNil(petList)
    }
}
