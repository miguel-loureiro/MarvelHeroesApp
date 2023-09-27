//
//  NetworkError.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 13/12/2022.
//

import Foundation

// MARK: Error types
public enum RequestError: Error , Equatable{
    
    case invalidURL
    case emptyData
    
    var customMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid url"
        case .emptyData:
            return "No data"
        }
    }
}
