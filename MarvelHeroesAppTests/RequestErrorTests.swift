//
//  RequestErrorTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 03/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class RequestErrorTests: XCTestCase {
    
    func testInvalidURLErrorCorrectString() {
        let resultError = RequestError.invalidURL
        let expectedError = "Invalid url"
        XCTAssertEqual(resultError.customMessage, expectedError)
    }
    func testEmptyDataCorrectString() {
        let resultError = RequestError.emptyData
        let expectedError = "No data"
        XCTAssertEqual(resultError.customMessage, expectedError)
    }
}
