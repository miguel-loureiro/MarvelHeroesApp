//
//  URLSessionMock.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 03/02/2023.
//

import Foundation
@testable import MarvelHeroesApp

class URLSessionMock: URLSessionProtocol, Mockable {
    
    var sessionType: EnumSessionType
    
    enum EnumSessionType {
        case emptyData
        case invalidURL
        case someCharactersData
        case someMockData
        case someComicsSmallData
        case someComicsBigData
        case someComicsEmptyData
        case someCharComicsData
        case someCharEventsData
        case someCharSeriesData
        case someCharStoriesData
        case localFile(filename: String)
    }
    
    init(sessionType: EnumSessionType) {
        self.sessionType = sessionType
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        switch sessionType {
        case .emptyData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = Data()
            return (data, response)
        case .invalidURL:
            throw RequestError.invalidURL
        case .someCharactersData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "CharactersResponse")
            return (data, response)
        case .someComicsSmallData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Character1009718ComicsSmall")
            return (data, response)
        case .someComicsBigData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Character1009718ComicsBig")
            return (data, response)
        case .someComicsEmptyData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Character1009718ComicsEmpty")
            return (data, response)
        case .someCharComicsData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Char_1010674_ComicsData")
            return (data, response)
        case .someCharEventsData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Char_1010674_EventsNoData")
            return (data, response)
        case .someCharSeriesData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Char_1010674_SeriesData")
            return (data, response)
        case .someCharStoriesData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "Char_1010674_StoriesData")
            return (data, response)
        case .someMockData:
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: "CharactersMockDataSmall")
            return (data, response)
        case .localFile(filename: let filename):
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let data = loadData(filename: filename, ext: "jpeg")
            return (data, response)
        }
    }
}
