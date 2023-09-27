//
//  URLBuilder.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 14/12/2022.
//

import Foundation

protocol URLBuilderProtocol {
    func url(relativePath: String, path: String, components: URLComponents) throws -> URL
    func fillComponents(_ limit: Int?, _ offset: Int?) -> URLComponents
    func create(ofType: Request, _ limit: Int?, _ offset: Int?) throws -> URL?
}

struct URLBuilder: URLBuilderProtocol { }

extension URLBuilderProtocol {
    
    func url(relativePath: String, path: String, components: URLComponents) throws -> URL {
        
        if let relativeURL = URL(string: relativePath, relativeTo: components.url),
           let url = URL(string: relativeURL.absoluteString)?.appending(path: path) {
            return url
        }
        throw RequestError.invalidURL
    }
    
    func fillComponents(_ limit: Int?, _ offset: Int?) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.API.scheme
        components.host = Constants.API.host
        
        let queryItems = [
            URLQueryItem(name: "ts", value: Constants.API.timeStamp),
            URLQueryItem(name: "limit", value: String(limit ?? 20)),
            URLQueryItem(name: "offset", value: String(offset ?? 0)),
            URLQueryItem(name: "apikey", value: Constants.API.publicKey),
            URLQueryItem(name: "hash", value: MD5Hash().generate())
        ]
        components.queryItems = queryItems
        return components
    }
    
    func create(ofType: Request, _ limit: Int?, _ offset: Int?) throws -> URL? {
        
        let relativePath = Constants.API.relativePath
        let components = fillComponents(limit, offset)
        let url = try self.url(relativePath: relativePath, path: MarvelEndpoint.characters.path, components: components)
        if let queryItems = components.queryItems {
            let endpointURL = {
                switch ofType {
                case .characters:
                    return url.appending(queryItems: queryItems)
                case .comic(let characterId):
                    return url.appending(path: MarvelEndpoint.comic(characterId: characterId)
                        .path).appending(queryItems: queryItems)
                case .event(let characterId):
                    return url.appending(path: MarvelEndpoint.event(characterId: characterId).path)
                        .appending(queryItems: queryItems)
                case .serie(let characterId):
                    return url.appending(path: MarvelEndpoint.serie(characterId: characterId).path)
                        .appending(queryItems: queryItems)
                case .story(let characterId):
                    return url.appending(path: MarvelEndpoint.story(characterId: characterId).path)
                        .appending(queryItems: queryItems)
                }
            }()
            return endpointURL
        }
        return nil
    }
}
