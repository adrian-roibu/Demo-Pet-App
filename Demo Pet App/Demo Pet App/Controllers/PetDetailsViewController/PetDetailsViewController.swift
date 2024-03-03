//
//  PetDetailsViewController.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 28.02.2024.
//

import UIKit

class PetDetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var petDetailsContentView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var breedSeparatorDotLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageSeparatorDotLabel: UILabel!
    @IBOutlet weak var genderSeparatorDotLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel: PetDetailsViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
        setCollectionViewFlowLayout()
        setupUI()
    }
    
    func registerCollectionViewCell() {
        let nib = UINib(nibName: Constants.UserInterface.Cells.petDetailsCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constants.UserInterface.Cells.petDetailsCollectionViewCell)
    }
    
    func setCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = .zero
        flowLayout.minimumLineSpacing = .zero
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        // MARK: Set label values
        nameLabel.text = viewModel.pet.name
        breedLabel.text = viewModel.pet.breeds?.primary
        locationLabel.text = viewModel.pet.contact?.address?.fullAddress
        ageLabel.text = viewModel.pet.age
        genderLabel.text = viewModel.pet.gender
        sizeLabel.text = viewModel.pet.size
        descriptionLabel.text = viewModel.pet.description
        
        self.title = viewModel.pet.name
        petDetailsContentView.layer.cornerRadius = Constants.UserInterface.Layer.petDetailsContentViewRadius
        
        // MARK: Setup page comntrol
        pageControl.numberOfPages = viewModel.pet.photos?.count ?? .zero
        pageControl.addTarget(self, action: #selector(pageControlHandle), for: .valueChanged)
    }
    
    // MARK: - Callbacks
    
    @objc func pageControlHandle(sender: UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout

extension PetDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height) 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UserInterface.Cells.petDetailsCollectionViewCell, for: indexPath) as! PetDetailsCollectionViewCell
        viewModel.setup(cell: cell, at: indexPath)
        
        return cell
    }
}
