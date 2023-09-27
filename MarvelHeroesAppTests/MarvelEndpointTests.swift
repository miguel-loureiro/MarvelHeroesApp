//
//  MarvelEndpointTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 02/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class MarvelEndpointTests: XCTestCase {

    let characterId = 1009718

    func testScheme() {
        // Assert
        XCTAssertEqual(MarvelEndpoint.characters.scheme, "https")
    }
    
    func testHost() {
        // Assert
        XCTAssertEqual(MarvelEndpoint.characters.host, "gateway.marvel.com")
    }
    
    func testRelativePath() {
        // Assert
        XCTAssertEqual(MarvelEndpoint.characters.relativePath, "/v1/public")
    }
    
    func testPath() {
        // Assert
        XCTAssertEqual(MarvelEndpoint.characters.path, "characters")
    }
    
    func testComicString() {
        // Act
        let expectedString = "\(characterId)/comics"
        // Assert
        XCTAssertEqual(MarvelEndpoint.comic(characterId: characterId).path, expectedString)
    }
    
    func testEventString() {
        // Act
        let expectedString = "\(characterId)/events"
        // Assert
        XCTAssertEqual(MarvelEndpoint.event(characterId: characterId).path, expectedString)
    }
    
    func testSerietring() {
        // Act
        let expectedString = "\(characterId)/series"
        // Assert
        XCTAssertEqual(MarvelEndpoint.serie(characterId: characterId).path, expectedString)
    }
    
    func testStoryString() {
        // Act
        let expectedString = "\(characterId)/stories"
        // Assert
        XCTAssertEqual(MarvelEndpoint.story(characterId: characterId).path, expectedString)
    }
}
