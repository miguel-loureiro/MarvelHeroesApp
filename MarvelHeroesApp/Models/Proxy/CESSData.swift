//
//  Data.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 10/01/2023.
//

import Foundation

struct CESSData: Decodable {

    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CESS]
}
