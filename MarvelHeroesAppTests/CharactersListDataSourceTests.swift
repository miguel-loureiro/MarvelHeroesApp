//
//  CharactersListDataSourceTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 07/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class CharactersListDataSourceTests: XCTestCase {
    
    func testFetchedCharactersWithDataWillAppendToInitialCharactersArray() async {
        // Arrange
        let dataSource = CharacterListDataSource(characters: [],
                                                 apiManager: RequestManager(session: URLSessionMock(sessionType: .someCharactersData)))
        // Act
        let response = await dataSource.fetchCharacters()
        // Assert
        XCTAssertGreaterThan(response.count, 0)
    }
    
    func testFetchedCharactersWithEmptyDataWillReturnInitialCharactersArray() async {
        // Arrange
        let dataSource = CharacterListDataSource(characters: [],
                                                 apiManager: RequestManager(session: URLSessionMock(sessionType: .emptyData)))
        // Act
        let response = await dataSource.fetchCharacters()
        // Assert
        XCTAssertEqual(response.count, 0)
    }
    
    func testGetIndexPathsToReloadShouldReturnExpectedResult() {
        // Arrange
        let dataSource = CharacterListDataSource(characters: [],
                                                 apiManager: RequestManager(session: URLSession.shared))
        dataSource.characters = [CharacterModel(id: 1, name: "SpiderMan", url: nil),
                                 CharacterModel(id: 2, name: "Thor", url: nil),
                                 CharacterModel(id: 3, name: "Wolverine", url: nil),
                                 CharacterModel(id: 4, name: "IronMan", url: nil)]
        // Act
        let result = dataSource.getIndexPathsToReload(2)
        // Assert
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?[0], IndexPath(item: 2, section: 0))
        XCTAssertEqual(result?[1], IndexPath(item: 3, section: 0))
    }
    
    func testGetIndexPathsToReloadWithInitialOffsetGreaterThanCharactersCountShouldReturnNil() {
        // Arrange
        let dataSource = CharacterListDataSource(characters: [], apiManager: RequestManager(session: URLSession.shared))
        dataSource.characters = [CharacterModel(id: 1, name: "SpiderMan", url: nil),
                                 CharacterModel(id: 2, name: "Thor", url: nil),
                                 CharacterModel(id: 3, name: "Wolverine", url: nil),
                                 CharacterModel(id: 4, name: "IronMan", url: nil)]
        // Act
        let result = dataSource.getIndexPathsToReload(4)
        // Assert
        XCTAssertNil(result)
    }
    
    func testConvertSucess() async {
        // Arrange // Data taken from Marvel API Interactive Documentation
        let char1id = 1011334
        let char1Name = "3-D Man"
        let char1URL = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/standard_xlarge.jpg") 
        let dataSource = CharacterListDataSource(characters: [],
                                                 apiManager: RequestManager(session: URLSessionMock(sessionType: .someMockData)))
        // Act
        let response = await dataSource.fetchCharacters()
        // Assert
        XCTAssertEqual(char1id, response[0].id)
        XCTAssertEqual(char1Name, response[0].name)
        XCTAssertEqual(char1URL, response[0].url)
    }
    
    func testConvertFailure() async {
        // Arrange // Data taken from Marvel API Interactive Documentation
        let char2id = 1017100
        let char2Name = "A-Bomb (HAS)"
        let dataSource = CharacterListDataSource(characters: [],
                                                 apiManager: RequestManager(session: URLSessionMock(sessionType: .someMockData)))
        // Act
        let response = await dataSource.fetchCharacters()
        // Assert
        XCTAssertEqual(char2id, response[1].id)
        XCTAssertEqual(char2Name, response[1].name)
        XCTAssertNil(response[1].url)
    }
}
