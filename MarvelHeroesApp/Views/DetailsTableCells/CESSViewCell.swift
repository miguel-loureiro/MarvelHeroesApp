//
//  CESSTableViewCell.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 20/01/2023.
//

import UIKit

class CESSTableViewCell: UITableViewCell {
    
    //    MARK: constants
    
    let identifier = "cess"
    let idLabelTopPadding = 5.0
    let idLabelLeftPadding = 5.0
    let idLabelRightPadding = -10.0
    let idLabelBottomPadding = 5.0
    
    let titleLabelTopPadding = 5.0
    let titleLabelLeftPadding = 15.0
    let titleLabelRightPadding = -10.0
    let titleLabelBottomPadding = 5.0
    
    let descriptionLabelTopPadding = 5.0
    let descriptionLabelLeftPadding = 20.0
    let descriptionLabelRightPadding = -10.0
    let descriptionLabelBottomPadding = 5.0
    
    //    MARK: variables
    
    var idLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Constants.CharacterDetailsVC.DetailsTableView.CESSViewCell.idLabelNumberOfLines
        label.font = Theme.Font.Headline
        label.textAlignment = .left
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Constants.CharacterDetailsVC.DetailsTableView.CESSViewCell.titleLabelNumberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = Theme.Font.Headline
        label.textAlignment =  .left
        return label
    }()
    
    var descriptionTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textAlignment = .justified
        textView.font = Theme.Font.Body
        
        return textView
    }()
    
    //    MARK: initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: view setup
    
    func setupViews() {
        self.addSubview(idLabel)
        self.addSubview(titleLabel)
        self.addSubview(descriptionTextField)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.idLabelTopPadding),
            idLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.idLabelLeftPadding),
            idLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.idLabelRightPadding),
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: self.idLabelBottomPadding),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.titleLabelTopPadding),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.titleLabelRightPadding),
            descriptionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                      constant: self.descriptionLabelTopPadding),
            descriptionTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                         constant: self.descriptionLabelBottomPadding),
            descriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])
    }
    
    //    MARK: Internal
    func configure(from model: CESSModel) {
        self.idLabel.text = String(model.id)
        self.titleLabel.text = model.title
        self.descriptionTextField.text = model.description
    }
}
