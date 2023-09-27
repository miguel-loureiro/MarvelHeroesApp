//
//  CESSResponse.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 11/01/2023.
//

import Foundation

struct CESSResponse: Decodable {

    let etag: String
    let data: CESSData
}
