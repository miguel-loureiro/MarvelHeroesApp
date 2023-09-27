//
//  CESSTableViewCellTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 10/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class CESSTableViewCellTests: XCTestCase {
    
    var cell = CESSTableViewCell()
    
    func testIdentifierIsExpected() {
        // Arrange
        let identifier = "cess"
        // Assert
        XCTAssertEqual(cell.identifier, identifier)
    }
    
    func testLabelsExist() {
        // Assert
        XCTAssertNotNil(cell.idLabel)
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertNotNil(cell.descriptionTextField)
    }
    
    func testConfigure() {
        // Assert
        let model = CESSModel(id: 1, title: "some title", description: "some description")
        // Act
        cell.configure(from: model)
        // Assert
        XCTAssertEqual(cell.idLabel.text, String(model.id))
        XCTAssertEqual(cell.titleLabel.text, model.title)
        XCTAssertEqual(cell.descriptionTextField.text, model.description)
    }
}
