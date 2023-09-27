//
//  MarvelCharacterCollectionViewCell.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 19/12/2022.
//

import UIKit

class MarvelCharacterCollectionViewCell: UICollectionViewCell {
    
    //    MARK: constants
    
    static let identifier = "MarvelCharacterCollectionViewCell"
    let thumbnailSpacingToTop = 1.0
    let thumbnailSpacingToLeft = 1.0
    let thumbnailSpacingToRight = -1.0
    let thumbnailSpacingToBottom = -40.0
    
    let labelSpacingToLeft = 1.0
    let labelSpacingToRight = -1.0
    
    var imageView = UIImageView()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.CharacterListVC.MarvelCharacterCell.NameLabel.labelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.Caption
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //    MARK: view setup
    
    func setupViews() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        //        MARK: using constraints
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.thumbnailSpacingToTop),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.thumbnailSpacingToLeft),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.thumbnailSpacingToRight),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.thumbnailSpacingToBottom),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: self.labelSpacingToLeft),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: self.labelSpacingToRight),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    override init(frame: CGRect)  {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: Internal
    func configure(from model: CharacterModel) {

        Task {
            let image = try await ImageFetcher().get(url: model.url)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        self.nameLabel.text = model.name
    }
}
