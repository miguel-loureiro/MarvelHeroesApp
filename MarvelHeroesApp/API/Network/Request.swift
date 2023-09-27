//
//  Request.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 15/12/2022.
//

import Foundation

enum Request {
    
    case characters
    case comic(characterId: Int)
    case event(characterId: Int)
    case serie(characterId: Int)
    case story(characterId: Int)
    
    var url: URL? {
        do {
            switch self {
            case .characters:
                return try URLBuilder().create(ofType: .characters, nil, nil)
            case .comic(characterId: let characterId):
                return try URLBuilder().create(ofType: .comic(characterId: characterId), nil, nil)
            case .event(characterId: let characterId):
                return try URLBuilder().create(ofType: .event(characterId: characterId), nil, nil)
            case .serie(characterId: let characterId):
                return try URLBuilder().create(ofType: .serie(characterId: characterId), nil, nil)
            case .story(characterId: let characterId):
                return try URLBuilder().create(ofType: .story(characterId: characterId), nil, nil)
            }
        } catch {
            return nil
        }
    }
}
