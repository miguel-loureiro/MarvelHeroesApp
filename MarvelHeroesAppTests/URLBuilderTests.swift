//
//  URLBuilderTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 27/01/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class URLBuilderTests: XCTestCase {
    
    let urlBuilder = URLBuilder()
    let urlBuilderMock = URLBuilderTestEmptyMock()
    let ts = String(Date().timeIntervalSince1970)
    let apikey = Constants.API.publicKey
    let urlHash = MD5Hash().generate()
    let ofType = Request.characters
    
    var components = URLComponents()
    
    let queryItems = [
        URLQueryItem(name: "ts", value: Constants.API.timeStamp),
        URLQueryItem(name: "limit", value: String(20)),
        URLQueryItem(name: "offset", value: String(0)),
        URLQueryItem(name: "apikey", value: Constants.API.publicKey),
        URLQueryItem(name: "hash", value: MD5Hash().generate())
    ]
    
    func testIfQueryItemsAreEmpty() throws {
        // Arrange
        let ofType = Request.characters
        // Act
        let url = try urlBuilderMock.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNil(url)
    }
    
    func testUrlThrowsErrorWhenBuildWithInvalidPathParameters() {
        
        // Arrange
        let relativePath = ""
        let path = ""
        // Act
        if let components = URLComponents(string: "something") {
            //Assert
            XCTAssertThrowsError(try urlBuilder.url(relativePath: relativePath, path: path, components: components)) { error in
                XCTAssertEqual(error as? RequestError, RequestError.invalidURL)
            }
        }
    }
    
    func testFillComponentsWithDefaultLimitAndOffset() {
        // Arrange
        let components = urlBuilder.fillComponents(nil, nil)
        XCTAssertEqual(components.scheme, Constants.API.scheme)
        XCTAssertEqual(components.host, Constants.API.host)
        // Assert
        XCTAssertEqual(components.queryItems?.count, 5)
        XCTAssertEqual(components.queryItems?[0].name, "ts")
        XCTAssertEqual(components.queryItems?[0].value, Constants.API.timeStamp)
        XCTAssertEqual(components.queryItems?[1].name, "limit")
        XCTAssertEqual(components.queryItems?[1].value, "20")
        XCTAssertEqual(components.queryItems?[2].name, "offset")
        XCTAssertEqual(components.queryItems?[2].value, "0")
        XCTAssertEqual(components.queryItems?[3].name, "apikey")
        XCTAssertEqual(components.queryItems?[3].value, Constants.API.publicKey)
        XCTAssertEqual(components.queryItems?[4].name, "hash")
        XCTAssertNotNil(components.queryItems?[4].value)
    }
    
    func testCreateCharactersURL() throws {
        
        // Arrange
        let ofType = Request.characters
        // Act
        let url = try urlBuilder.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNotNil(url)
    }
    
    func testCreateComicURL() throws {
        
        // Arrange
        let characterId = 1009718
        let ofType = Request.comic(characterId: characterId)
        // Act
        let url = try urlBuilder.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNotNil(url)
    }
    
    func testCreateEventURL() throws {
        
        // Arrange
        let characterId = 1009718
        let ofType = Request.event(characterId: characterId)
        // Act
        let url = try urlBuilder.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNotNil(url)
    }
    
    func testCreateSerieURL() throws {
        
        // Arrange
        let characterId = 1009718
        let ofType = Request.serie(characterId: characterId)
        // Act
        let url = try urlBuilder.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNotNil(url)
    }
    
    func testCreateStoryURL() throws {
        
        // Arrange
        let characterId = 1009718
        let ofType = Request.story(characterId: characterId)
        // Act
        let url = try urlBuilder.create(ofType: ofType, nil, nil)
        // Assert
        XCTAssertNotNil(url)
    }
    
    func testURLNil() {
        // Arrange
        let urlBuilder = URLBuilderTestURLNil()
        // Act and Assert
        XCTAssertThrowsError(try urlBuilder.create(ofType: ofType, nil, nil))
        { error in XCTAssertEqual(error as? RequestError, RequestError.invalidURL)}
    }
}
