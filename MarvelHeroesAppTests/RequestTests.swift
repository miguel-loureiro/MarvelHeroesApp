//
//  RequestTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 02/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class RequestTests: XCTestCase {
    
    func testURLForCharacters() throws {
        // Arrange
        let request = Request.characters
        // Assert
        XCTAssertNotNil(request.url)
    }
    
    func testURLForComic() throws {
        // Arrange
        let request = Request.comic(characterId: 1009718)
        // Assert
        XCTAssertNotNil(request.url)
    }
    
    func testURLForEvent() throws {
        // Arrange
        let request = Request.event(characterId: 1009718)
        // Assert
        XCTAssertNotNil(request.url)
    }
    
    func testURLForSerie() throws {
        // Arrange
        let request = Request.serie(characterId: 1009718)
        // Assert
        XCTAssertNotNil(request.url)
    }
    
    func testURLForStory() throws {
        // Arrange
        let request = Request.story(characterId: 1009718)
        // Assert
        XCTAssertNotNil(request.url)
    }
}
