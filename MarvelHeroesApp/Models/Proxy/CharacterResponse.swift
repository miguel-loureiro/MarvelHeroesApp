//
//  Results.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 08/12/2022.
//

import Foundation

struct CharacterResponse: Decodable {

    let etag: String
    let data: CharacterData
}
