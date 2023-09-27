//
//  ViewController.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 05/12/2022.
//

import UIKit

class CharactersListController: UIViewController, UINavigationControllerDelegate {

    //    MARK: constants

    static let sectionSpacingToHeader = 0.0
    static let sectionSpacingToLeft = 0.0
    static let sectionSpacingToRight = 0.0
    static let sectionSpacingToFooter = 10.0
    static let numberOfSections = 1
    static let minimumLineSpacing = 1.0
    static let minimumInterItemSpacing = 1.0
    static let widthPartition = 4.05
    static let heightPartition = 6.05
    static let footerHeight = 40.0

    //  MARK: variables declaration/initiation
    
    var dataSource = CharacterListDataSource(characters: [], apiManager: RequestManager(session: URLSession.shared))
    var loadingView: LoadingReusableView?
    var hasher = MD5Hash()
    
    //    MARK: Collection view declaration/initialization
    
    private let collectionView: UICollectionView = {
        
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    //    MARK: view setup
    
    private func setupViews() {

        self.title = "Characters list"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate =  self
        collectionView.register(MarvelCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: MarvelCharacterCollectionViewCell.identifier)
        collectionView.register(LoadingReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LoadingReusableView.identifier)
    }
    
    //    MARK: view layout setup
    
    private func setupLayouts() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    //    MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        
        Task {
            let model = await self.dataSource.fetchCharacters()
            
            DispatchQueue.main.async {
                self.dataSource.characters.append(contentsOf: model)
                self.collectionView.reloadData()
            }
        }
    }
}
