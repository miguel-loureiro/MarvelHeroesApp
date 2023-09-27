//
//  ViewController+CollectionView.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 20/12/2022.
//

import UIKit

extension CharactersListController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return CharactersListController.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.identifier, for: indexPath) as? LoadingReusableView {
            return footer
        }
        return UICollectionReusableView()
    }
}

extension CharactersListController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharacterCollectionViewCell.identifier, for: indexPath)
        as! MarvelCharacterCollectionViewCell
        
        cell.configure(from: self.dataSource.characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            if dataSource.characters.count > 0 {
                
                let initialOffset = dataSource.characters.count
                
                Task {
                    let model = await self.dataSource.fetchCharacters()
                    
                    DispatchQueue.main.async() {
                        
                        self.dataSource.characters.append(contentsOf: model)
                        if let indexPathsToReload = self.dataSource.getIndexPathsToReload(initialOffset) {
                            
                            collectionView.performBatchUpdates({ collectionView.insertItems(at: indexPathsToReload)}, completion: nil)
                        }
                    }
                }
            }
            self.loadingView?.indicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.indicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.dataSource.characters[indexPath.row]
        let detailsViewContoller = DetailsViewController(characterModel: character)
        self.navigationController?.pushViewController(detailsViewContoller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharacterCollectionViewCell.identifier, for: indexPath)
        as! MarvelCharacterCollectionViewCell
        cell.backgroundColor = UIColor.clear
    }
}

extension CharactersListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width / CharactersListController.widthPartition ,
                      height: view.frame.size.height / CharactersListController.heightPartition)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(CharactersListController.minimumLineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(CharactersListController.minimumInterItemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: CharactersListController.sectionSpacingToHeader,
                            left: CharactersListController.sectionSpacingToLeft,
                            bottom: CharactersListController.sectionSpacingToFooter,
                            right: CharactersListController.sectionSpacingToRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: CharactersListController.footerHeight)
    }
}
