//
//  CollectionReusableView.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 28/12/2022.
//

import UIKit

class LoadingReusableView: UICollectionViewCell {
    
    //    MARK: constants
    
    static let identifier = "footer"
    
    //    MARK: Loader instantiation
    
    var indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //    MARK: View setup
    
    func setup(){
        contentView.addSubview(indicator)
        indicator.center = contentView.center
        indicator.style = .medium
        indicator.color = .black
        indicator.startAnimating()
        indicator.hidesWhenStopped = false
    }
}
