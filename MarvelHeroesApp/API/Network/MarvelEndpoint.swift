//
//  Endpoint.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 13/12/2022.
//

import Foundation

enum MarvelEndpoint {
    case characters
    case comic(characterId: Int)
    case event(characterId: Int)
    case serie(characterId: Int)
    case story(characterId: Int)
}

extension MarvelEndpoint {
    
    var scheme: String {
        return "https"
    }
    var host: String {
        return "gateway.marvel.com"
    }
    var relativePath: String {
        return "/v1/public"
    }
    var path: String {
        switch self {
        case .characters:
            return "characters"
        case .comic(characterId: let characterId):
            return "\(characterId)/comics"
        case .event(characterId: let characterId):
            return "\(characterId)/events"
        case .serie(characterId: let characterId):
            return "\(characterId)/series"
        case .story(characterId: let characterId):
            return "\(characterId)/stories"
        }
    }
}
