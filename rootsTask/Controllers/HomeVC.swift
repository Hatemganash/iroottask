//
//  HomeVC.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

class HomeVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet weak var dataCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var horizontalImages: [UIImage] = []
    var verticalImages: [UIImage] = []
    let fakeImages: [UIImage] = [
        UIImage(named: "fake1")!,
        UIImage(named: "fake2")!,
        UIImage(named: "fake3")!
    ]
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        dataCollectionView.layoutIfNeeded()
        collectionHeightConstraint.constant = dataCollectionView.contentSize.height
    }
}

//MARK: - Configurations
extension HomeVC {

    func setupCollectionView() {
        horizontalImages = (0..<10).map { _ in fakeImages.randomElement()! }
        verticalImages = (0..<20).map { _ in fakeImages.randomElement()! }
        dataCollectionView.collectionViewLayout = createLayout()
        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        dataCollectionView.registerCell(cell: ImageViewCell.self)

    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            sectionIndex, environment in
            if sectionIndex == 0 {
                return self.horizontalSection()
            } else {
                return self.verticalSection()
            }
        }
    }

    func horizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(120), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
    }

    func verticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
    }
}

//MARK: - UICollectionView Configurations
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return section == 0 ? 10 : 20
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
       
            let cell : ImageViewCell = dataCollectionView.dequeue(inx: indexPath)
        let image = indexPath.section == 0
               ? horizontalImages[indexPath.item]
               : verticalImages[indexPath.item]
           
           cell.setupCell(data: image)
            return cell
       
    }
}


