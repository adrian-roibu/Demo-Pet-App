//
//  HomeViewController.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var petListTableView: UITableView!
    
    var viewModel: HomeViewModel!
    var coordinator: MainFlowController?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        initBindings()
        viewModel.loadData()
        
        self.title = "Pet Finder"
    }
    
    // MARK: - Bindings
    
    func initBindings() {
        viewModel.pets.asObserver()
            .bind { [weak self] _ in
                self?.petListTableView.reloadData()
                self?.petListTableView.refreshControl?.endRefreshing()
                self?.petListTableView.tableFooterView = nil
            }.disposed(by: disposeBag)
        
        viewModel.error.asObserver()
            .bind { [weak self] errorMessage in
                self?.coordinator?.showAlert(with: errorMessage, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Setup UI
    
    private func tableViewSetup() {
        // register cell
        let nib = UINib(nibName: Constants.UserInterface.Cells.petListTableViewCell, bundle: nil)
        petListTableView.register(nib, forCellReuseIdentifier: Constants.UserInterface.Cells.petListTableViewCell)
        
        // set refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        
        petListTableView.refreshControl = refreshControl
        
    }
    
    private func showTableFooterView() {
        // set table footer
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.frame = CGRect(x: .zero, y: .zero, width: petListTableView.bounds.width, height: Constants.UserInterface.Layer.activityIndicatorHeight)
        activityIndicatorView.startAnimating()
        petListTableView.tableFooterView = activityIndicatorView
    }
    
   
    
    // MARK: - Callbacks
    
    @objc private func refreshList() {
        viewModel.retrievePetList()
    }
    
    func presentPetDetails(at indexPath: IndexPath) {
        guard let pet = viewModel.petsValue?.animals[indexPath.row] else { return }
        
        coordinator?.presentPetDetailsViewController(with: pet)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petListTableView.dequeueReusableCell(withIdentifier: Constants.UserInterface.Cells.petListTableViewCell, for: indexPath) as! PetListTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let animals = viewModel.petsValue?.animals else { return }
        if indexPath.item == animals.count - 3 {
            self.showTableFooterView()
            self.viewModel.retrievePetList(with: viewModel.petsValue?.pagination.links?.next?.href)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        petListTableView.deselectRow(at: indexPath, animated: true)
        
        presentPetDetails(at: indexPath)
    }
}
