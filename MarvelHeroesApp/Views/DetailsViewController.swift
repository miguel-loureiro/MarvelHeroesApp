//
//  DetailsTableViewController.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 09/01/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //    MARK: Constants
    
    let dataSource: DetailsDataSource
    let detailsHeaderView = DetailsHeaderView(characterModel: CharacterModel(id: 0, name: " ", url: nil ))
    let sectionHeaderHeight = Constants.CharacterDetailsVC.DetailsTableView.sectionHeaderHeight
    
    //    MARK: details table view initialization
    
    let detailsTableView: UITableView = {
        
        let details = UITableView()
        details.register(CESSTableViewCell.self, forCellReuseIdentifier: Constants.CharacterDetailsVC.DetailsTableView.CESSViewCell.identifier)
        return details
    }()
    
    private func setupView() {
        view.addSubview(detailsHeaderView)
        view.addSubview(detailsTableView)
    }
    
    init(characterModel: CharacterModel) {
        dataSource = DetailsDataSource(character: characterModel, apiManager: RequestManager(session: URLSession.shared)) // Comics array is initilized here and is []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderView() {
        detailsHeaderView.configure(from: dataSource.character)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Character details"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        setupView()
        setupHeaderView()
        view.addSubview(detailsHeaderView)
        view.addSubview(detailsTableView)
        setupSubViews()
        
        Task {
            
            let _ = try await self.dataSource.fetchCESSDataParallel()
            DispatchQueue.main.async {
                self.detailsTableView.dataSource = self
                self.detailsTableView.delegate = self
                self.detailsTableView.reloadData()
            }
        }
    }
    
    func setupSubViews() {
        
        detailsHeaderView.translatesAutoresizingMaskIntoConstraints = false
        detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsTableView.topAnchor.constraint(equalTo: self.detailsHeaderView.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //   MARK: frame for table view
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
