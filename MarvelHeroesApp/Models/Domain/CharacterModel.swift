//
//  CharacterList.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 05/01/2023.
//

import Foundation

struct CharacterModel: Decodable {

    let id: Int
    let name: String
    let url: URL?
}
