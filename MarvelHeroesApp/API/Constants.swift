//
//  APIConstants.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 13/12/2022.
//

import UIKit

struct Constants {
    
    //    MARK: constants declaration/initialization for API access and data fetch
    struct API {
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        static let relativePath = "/v1/public"
        static let timeStamp = String(Date().timeIntervalSince1970)
        static let privateKey = "b8cc7f94bf4e666a4d0ef95973e92c59ff27d891"
        static let publicKey = "94ae4ea7768532e508b53e5f3fd6a393"
        static let apiBaseEndPoint = "https://gateway.marvel.com/"
        static let limit = 20
        static let offset = 0
    }
    
    struct CharacterListVC {
        struct MarvelCharacterCell {
            struct NameLabel {
                static let labelNumberOfLines = 2
            }
        }
    }
    
    struct CharacterDetailsVC {
        struct DetailsHeaderView {
            static let nameLabelNumberOfLines = 2
        }
        struct DetailsTableView {
            static let cellIdentifier = "cell"
            static let sectionHeaderHeight =  30.0
            struct CESSViewCell {
                static let identifier = "cess"
                static let idLabelNumberOfLines = 1
                static let titleLabelNumberOfLines = 2
                static let descriptionLabelNumberOfLines = 20
            }
        }
    }
    
    struct DetailsDataSource {
        static let maximumElementsToDisplay = 3
    }
}

