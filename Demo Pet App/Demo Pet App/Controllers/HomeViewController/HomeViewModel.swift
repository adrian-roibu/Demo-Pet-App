//
//  HomeViewModel.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 27.02.2024.
//

import RxSwift

class HomeViewModel {
    var pets: BehaviorSubject<Pets?> = BehaviorSubject(value: nil)
    var error: PublishSubject<String> = PublishSubject()
    
    var petsValue: Pets? {
        return try? pets.value()
    }
    
    var isLoading = false
    private let petsNetworkService: PetsNetworkService
    private let disposeBag = DisposeBag()
    private var pageCounter = 1
    
    private let tokenManager = AccessTokenManager.sharedInstance
    
    init(petsNetworkService: PetsNetworkService) {
        self.petsNetworkService = petsNetworkService
    }
    
    func loadData() {
        if tokenManager.isTokenValid() {
            retrievePetList()
        } else {
            fetchOauthToken()
        }
    }
    
    func retrievePetList(with pagination: String? = nil) {
        guard !isLoading else { return }
        
        isLoading = true
        petsNetworkService.getPetsList(paginationHref: pagination) { [weak self] (result) in
            switch result {
            case let .success(petList):
                if let pets = petList {
                    self?.handlePetList(with: pets)
                    self?.isLoading = false
                }
                
            case let .failure(error):
                if error.asAFError?.responseCode == 401 {
                    self?.fetchOauthToken()
                } else {
                    self?.error.onNext(error.localizedDescription)
                }
                self?.isLoading = false
            }
        }
    }
    
    // MARK: - Oauth fetch
    
    func fetchOauthToken() {
        petsNetworkService.fetchAccessToken { [weak self] success in
            switch success {
            case true:
                self?.retrievePetList()
            case false:
                self?.error.onNext(Constants.UserInterface.Error.oAuthTokenFailed)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func handlePetList(with data: Pets) {
        pageCounter = data.pagination.current_page
        if pageCounter == 1 {
            pets.onNext(nil)
            pets.onNext(data)
        } else if let existingPets = petsValue?.animals {
            var animals: [Pet] {
                return existingPets + data.animals
            }
            
            let updatedPetList = Pets(animals: animals, pagination: data.pagination)
            pets.onNext(updatedPetList)
        }
    }
    
    // MARK: - Tableview configuration
    
    func cellViewModel(at indexPath: IndexPath) -> PetListTableViewCellViewModel? {
        guard let pet = petsValue?.animals[indexPath.row] else {
            return nil
        }
        return PetListTableViewCellViewModel(pet: pet)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return petsValue?.animals.count ?? .zero
    }
}
