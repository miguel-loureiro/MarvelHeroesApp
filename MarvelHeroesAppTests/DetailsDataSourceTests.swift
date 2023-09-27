//
//  DetailsDataSourceTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 07/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class DetailsDataSourceTests: XCTestCase {
    
    // MARK: global properties
    let characterId = 1010674
    let model = CharacterModel(id: 1, name: "a", url: nil)
    
    func testFetchCESSWithEmptyDataWillThrowError() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .emptyData))
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        // Act
        let response = await dataSource.fetchCESS(request: Request.comic(characterId: 0))
        // Assert
        XCTAssertEqual(response.isEmpty, true, "If no data is fetched then no data is added to the starting empty array")
    }
    
    func testFetchCESSParalellSuccess() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .someComicsBigData))
        let dataSource = DetailsDataSource(character: model , apiManager: apiManager)
        // Act and Assert
        do {
            let cessResult = try await dataSource.fetchCESSDataParallel()
            XCTAssertNotNil(cessResult)
        } catch {
            XCTFail("Failed")
        }
    }
    
    func testNumberOfRowsInSectionWillReturnMinimumBetweenItemsCountAndMaxAllowedItemsCount() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .someComicsSmallData))
        let expectedNumberOfRows = 2
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        // Act
        do {
            _ = try await dataSource.fetchCESSDataParallel()
            // Assert
            XCTAssertEqual(dataSource.numberOfRowsInDetailsSections(of: 0), expectedNumberOfRows)
        } catch {
            XCTFail("Failed")
        }
    }
    
    func testNumberOfRowsInSectionWillReturnMaxAllowedItemsCount() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .someComicsBigData))
        let expectedNumberOfRows = 3
        let dataSource = DetailsDataSource(character: model , apiManager: apiManager)
        // Act
        do {
            _ = try await dataSource.fetchCESSDataParallel()
            // Assert
            XCTAssertEqual(dataSource.numberOfRowsInDetailsSections(of: 0), expectedNumberOfRows)
        } catch {
            XCTFail("Failed")
        }
    }
    
    func testNumberOfRowsInSectionWillReturnZeroIfDataIsEmpty() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .someComicsBigData))
        let expectedNumberOfRows = 0
        let dataSource = DetailsDataSource(character: model , apiManager: apiManager)
        // Act
        let result = dataSource.numberOfRowsInDetailsSections(of: 0)
        // Assert
        XCTAssertEqual(result, expectedNumberOfRows)
    }
    
    func testUpdateTitlesWillReturnExpectedResult() async {
        // Arrange
        let apiManager = RequestManager(session: URLSession.shared)
        let expectedNumberOfTiltes = 4
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        // Act
        let resultNumberOfSections = dataSource.numberOfSections()
        // Assert
        XCTAssertEqual(resultNumberOfSections, expectedNumberOfTiltes)
    }
    
    func testUpdateTitlesWillReturnExpectedResultWithEmptySections() async {
        // Arrange
        let apiManager = RequestManager(session: URLSession.shared)
        let apiManagerComics = RequestManager(session: URLSessionMock(sessionType: .someCharComicsData))
        let apiManagerEvents = RequestManager(session: URLSessionMock(sessionType: .someCharEventsData))
        let apiManagerSeries = RequestManager(session: URLSessionMock(sessionType: .someCharSeriesData))
        let apiManagerStories = RequestManager(session: URLSessionMock(sessionType: .someCharStoriesData))
        let expectedNumberOfTitles = 3
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        let dataSourceComics = DetailsDataSource(character: model, apiManager: apiManagerComics)
        let dataSourceEvents = DetailsDataSource(character: model, apiManager: apiManagerEvents)
        let dataSourceSeries = DetailsDataSource(character: model, apiManager: apiManagerSeries)
        let dataSourceStories = DetailsDataSource(character: model, apiManager: apiManagerStories)
        var responseCESS = dataSource.cess
        // Act
        let responseComics = await dataSourceComics.fetchCESS(request: Request.comic(characterId: characterId))
        let responseEvents = await dataSourceEvents.fetchCESS(request: Request.event(characterId: characterId))
        let responseSeries = await dataSourceSeries.fetchCESS(request: Request.serie(characterId: characterId))
        let responseStories = await dataSourceStories.fetchCESS(request: Request.story(characterId: characterId))
        responseCESS[.comics] = responseComics
        responseCESS[.events] = responseEvents
        responseCESS[.series] = responseSeries
        responseCESS[.stories] = responseStories
        dataSource.cess = responseCESS
        let resultNumberOfSections = dataSource.numberOfSections()
        XCTAssertEqual(resultNumberOfSections, expectedNumberOfTitles)
    }
    
    func testRowsOfSectionWillReturnExpectedNumberOfItems() async {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .someComicsSmallData))
        let index = IndexPath(row: 0, section: 0)
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        var responseCESS = dataSource.cess
        // Act
        let response = await dataSource.fetchCESS(request: Request.comic(characterId: characterId))
        responseCESS[.comics] = response
        let row = dataSource.rowsOfSection(from: responseCESS, at: index)
        // Assert
        XCTAssertNotNil(row)
    }
    
    func testRowOfSectionWillReturnNilWhenSectionIsNotAvailable() {
        // Arrange
        let apiManager = RequestManager(session: URLSessionMock(sessionType: .emptyData))
        let index = IndexPath(row: 1, section: 1)
        let dataSource = DetailsDataSource(character: model, apiManager: apiManager)
        // Act
        let rows = dataSource.rowsOfSection(from: dataSource.cess, at: index)
        // Assert
        XCTAssertNil(rows)
    }
}
