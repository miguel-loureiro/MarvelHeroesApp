//
//  MarvelCharacterCollectionViewCellTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 10/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class MarvelCharacterCollectionViewCellTests: XCTestCase {
    
    var cell = MarvelCharacterCollectionViewCell()
    let model = CharacterModel(id: 1, name: "some name", url: nil)
    
    func testIdentifierIsExpected() {
        // Arrange
        let identifier = "MarvelCharacterCollectionViewCell"
        // Assert
        XCTAssertEqual(MarvelCharacterCollectionViewCell.identifier, identifier)
    }
    
    func testSetupViewsWillAddSubViewsAsExpected() {
        // Arrange
        let imageView = UIImageView()
        let nameLabel = UILabel()
        // Act
        cell.setupViews()
        // Assert
        XCTAssertNotNil(imageView)
        XCTAssertNotNil(nameLabel)
        XCTAssertTrue(cell.contentView.subviews.contains(cell.imageView))
        XCTAssertTrue(cell.contentView.subviews.contains(cell.nameLabel))
    }
    
    func testConfigureNameLabelResultIsExpected() {
        // Act
        cell.configure(from: model)
        // Assert
        XCTAssertEqual(cell.nameLabel.text, model.name, "Name sould be equal to some name")
    }
    
    func testConfigureThumbnailImageResultIsExpected()  {
        // Act
        cell.configure(from: model)
        // Assert
        XCTAssertNil(cell.imageView.image, "Image should be nil")
    }
    
    func testLoadImage() async  {
        // Act
        do {
            // Arrange
            let session = URLSessionMock(sessionType: .localFile(filename: "hero"))
            let image = try await ImageFetcher().get(url: URL(string: "www.apple"), session: session)
            // Assert
            XCTAssertNotNil(image)
        } catch  {
            XCTFail("Failed")
        }
    }
}
