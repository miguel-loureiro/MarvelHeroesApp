//
//  MarvelAPI.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 14/12/2022.
//

import Foundation
import CryptoKit


protocol RequestManagerProtocol {
    
    func fetchData<T:Decodable>(limit: Int?, offset: Int?, typeOf: Request) async throws -> T
}

class RequestManager: RequestManagerProtocol  {
    
    // MARK: DI of session to any RequestManager
    let session: URLSessionProtocol
    let urlBuilder: URLBuilderProtocol
    
    init(session: URLSessionProtocol, urlBuilder: URLBuilderProtocol = URLBuilder()) {
        self.session =  session
        self.urlBuilder = urlBuilder
    }
    
    //    MARK: get Marvel data
    
    func fetchData<T:Decodable>(limit: Int?, offset: Int?, typeOf: Request) async throws -> T {
        
        if let endpointURL = try self.urlBuilder.create(ofType: typeOf , limit, offset) {
            let (data, _) = try await session.data(from: endpointURL)
            if let decodedCharacterData = try? JSONDecoder().decode(T.self, from: data) {
                return decodedCharacterData
            } else {
                throw RequestError.emptyData
            }
        }
        throw RequestError.invalidURL
    }
}
