//
//  Character.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 05/12/2022.
//

import Foundation

struct Character: Decodable {

    let id: Int
    let name: String
    let thumbnail: Thumbnail?
}
