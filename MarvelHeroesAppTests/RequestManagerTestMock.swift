//
//  RequestManagerTestMock.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 06/02/2023.
//

import Foundation
@testable import MarvelHeroesApp

class RequestManagerTestMock: RequestManagerProtocol, Mockable {
    func fetchData<T>(limit: Int?, offset: Int?, typeOf: MarvelHeroesApp.Request) async throws -> T where T : Decodable {
        return loadJSON(filename: "CharactersResponse", type: T.self)
    }
}
