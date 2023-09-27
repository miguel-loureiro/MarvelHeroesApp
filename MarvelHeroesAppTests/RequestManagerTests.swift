//
//  RequestManagerTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 30/01/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class RequestManagerTests: XCTestCase {
    
    func testFetchCharactersDecodedDataSuccess() async {
        
        let request = RequestManager(session: URLSessionMock(sessionType: .someCharactersData))
        do {
            let response: CharacterResponse = try await request.fetchData(limit: 20, offset: 0, typeOf: Request.characters)
            XCTAssertEqual(response.data.results.count, 1)
            XCTAssertNotNil(response)
        }
        catch {
            XCTFail("Failed")
        }
    }
    
    func testFetchCharactersNoDataThrowsError() async {
        let request = RequestManager(session: URLSessionMock(sessionType: .emptyData))
        do {
            let _: CharacterResponse = try await request.fetchData(limit: nil, offset: nil, typeOf: Request.characters)
        } catch let error as RequestError{
            XCTAssertEqual(error, RequestError.emptyData)
        } catch {
            XCTFail("Failed")
        }
    }
    
    func testFetchCharactersFailureInvalidURL() async {
        let request = RequestManager(session: URLSessionMock(sessionType: .invalidURL), urlBuilder: URLBuilderTestEmptyMock())
        do {
            let _: CharacterResponse = try await request.fetchData(limit: nil, offset: nil, typeOf: Request.characters)
            XCTFail("Failed")
        } catch let error as RequestError {
            XCTAssertEqual(error, RequestError.invalidURL)
        } catch {
            XCTFail("Failed")
        }
    }
}
