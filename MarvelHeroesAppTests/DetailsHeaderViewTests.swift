//
//  DetailsHeaderViewTests.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 10/02/2023.
//

import XCTest
@testable import MarvelHeroesApp

final class DetailsHeaderViewTests: XCTestCase {
    
    var detailsHeaderView = DetailsHeaderView(characterModel: CharacterModel(id: 1, name: "some name", url: nil))
    
    func testDetailsHeaderViewInitialization() {
        XCTAssertNotNil(detailsHeaderView)
        XCTAssertNotNil(detailsHeaderView.thumbnailImageView)
        XCTAssertNotNil(detailsHeaderView.nameLabel)
    }
    
    func testDetailsHeaderViewConstraints() {
        let constraints = detailsHeaderView.constraints
        XCTAssertTrue(constraints.contains { $0.firstAttribute == .width && $0.constant == UIScreen.main.bounds.width })
        XCTAssertTrue(constraints.contains { $0.firstAttribute == .height &&
            $0.constant == (UIScreen.main.bounds.width * detailsHeaderView.thumbnailImageReductionFactor) })
    }
    
    func testConfigureSuccess(){
        // Assert
        let model = CharacterModel(id: 1, name: "some character", url: nil)
        let detailsHeaderView = DetailsHeaderView(characterModel: model)
        // Act
        detailsHeaderView.configure(from: model)
        // Assert
        XCTAssertEqual(detailsHeaderView.nameLabel.text, model.name)
    }
}
