//
//  Image.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 05/12/2022.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
