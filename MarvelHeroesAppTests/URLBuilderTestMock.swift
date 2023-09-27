//
//  URLBuildTestMock.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 31/01/2023.
//

import Foundation
@testable import MarvelHeroesApp

struct URLBuilderTestMock: URLBuilderProtocol {
    
    func fillComponents(_ limit: Int?, _ offset: Int?) -> URLComponents {
        URLComponents()
    }
}

struct URLBuilderTestEmptyMock: URLBuilderProtocol {
    
    func create(ofType: Request, _ limit: Int?, _ offset: Int?) throws -> URL? {
        return nil
    }
}

struct URLBuilderTestErrorMock: URLBuilderProtocol {
    
    func create(ofType: Request, _ limit: Int?, _ offset: Int?) throws -> URL? {
        throw RequestError.invalidURL
    }
}

struct URLBuilderTestURLNil: URLBuilderProtocol {
    
    func url(relativePath: String, path: String, components: URLComponents) throws -> URL {
        throw RequestError.invalidURL
        
    }
}
