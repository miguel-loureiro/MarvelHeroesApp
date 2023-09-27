//
//  DetailsViewController+TableView.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 12/01/2023.
//

import UIKit

extension DetailsViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.numberOfRowsInDetailsSections(of: section)
    }
}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titlesDetailSection = self.dataSource.titles[section]
        return titlesDetailSection.description
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> (UITableViewCell) {
        let cellIdentifier = Constants.CharacterDetailsVC.DetailsTableView.CESSViewCell.identifier
        if let cell = detailsTableView.dequeueReusableCell(withIdentifier: cellIdentifier ,
                                                           for: indexPath) as? CESSTableViewCell,
           let item = self.dataSource.rowsOfSection(from: self.dataSource.cess ,
                                                    at: indexPath) {
            cell.configure(from: item)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.sectionHeaderHeight
    }
}
