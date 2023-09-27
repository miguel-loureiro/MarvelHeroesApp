//
//  URLSessionMock.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 01/02/2023.
//

import Foundation

protocol URLSessionProtocol {
    
    func data(from url: URL ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
