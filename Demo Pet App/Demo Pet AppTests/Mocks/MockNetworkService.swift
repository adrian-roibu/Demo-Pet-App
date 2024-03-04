//
//  MockNetworkService.swift
//  Demo Pet AppTests
//
//  Created by Adrian Roibu on 03.03.2024.
//

import Foundation

final class MockNetworkService: PetsNetworkService {
    // check if the viewModel really requests data from the PetsNetworkService
    var isGetPetsListCalled = false
    var completeClosure: (ResultCompletion<Pets>?)!
    var completeAccessTokenClosure: ((Bool) -> Void)!
    
    var completePetList: Pets {
        let petListJson = Bundle.main.url(forResource: "Pets", withExtension: "json")
        let data = try! Data(contentsOf: petListJson!)
        
        let petList = try! JSONDecoder().decode(Pets.self, from: data)
        
        return petList
    }

    func getPetsList(paginationHref: String? = nil, completion: ResultCompletion<Pets>?) {
        isGetPetsListCalled = true
        completeClosure = completion
    }
    
    func fetchPetListSuccess() {
        completeClosure!(.success(completePetList))
    }
    
    func fetchPetListFail(error: Error?) {
        completeClosure!(.failure(error!))
    }
    
    func fetchAccessToken(completion: @escaping (Bool) -> Void) {
        completeAccessTokenClosure = completion
    }
}
