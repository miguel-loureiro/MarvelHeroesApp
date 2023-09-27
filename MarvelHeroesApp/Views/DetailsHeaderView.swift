//
//  DetailsHeaderView.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 13/01/2023.
//

import UIKit

class DetailsHeaderView: UIView {
    
    //    MARK: constants
    
    let thumbnailImageReductionFactor = 1 / 1.3
    let thumbnailImageBottomPadding: CGFloat = 40.0
    let nameLabelWidthReductionFactor = 0.9
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.CharacterDetailsVC.DetailsHeaderView.nameLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.LargeTitle
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        
        return label
    }()
    
    //    MARK: view initialization
    init(characterModel: CharacterModel ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thumbnailImageView)
        self.addSubview(nameLabel)
        self.backgroundColor = .clear
        let screenWidth = UIScreen.main.bounds.width
        // Layout constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: screenWidth),
            self.heightAnchor.constraint(equalToConstant: (screenWidth * self.thumbnailImageReductionFactor)),
            thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: screenWidth * self.thumbnailImageReductionFactor),
            nameLabel.topAnchor.constraint(equalTo: self.thumbnailImageView.bottomAnchor,
                                           constant: self.thumbnailImageBottomPadding),
            nameLabel.widthAnchor.constraint(equalToConstant: screenWidth * self.nameLabelWidthReductionFactor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: Internal
    
    func configure(from model: CharacterModel) {
        Task {
            let image = try await ImageFetcher().get(url: model.url)
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        self.nameLabel.text = model.name
    }
}
