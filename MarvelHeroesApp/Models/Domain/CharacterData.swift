//
//  CharacterData.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 04/01/2023.
//

import Foundation

struct CharacterData: Decodable {

    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}
