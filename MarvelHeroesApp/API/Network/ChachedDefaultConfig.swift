//
//  ChachedDefaultConfig.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 16/02/2023.
//

import Foundation

extension URLSession {

    static func defaultConfig()  -> URLSession {

        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
}
