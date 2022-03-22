//
//  TitleCell.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var appIconImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var installButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(from result: Result) {        
        appIconImage.imageFromUrl(result.artworkUrl512, image: UIImage())
        // iconImage border
        appIconImage.layer.borderWidth = 1
        appIconImage.layer.borderColor = UIColor(white: 0.3, alpha: 0.3).cgColor
        appIconImage.layer.cornerCurve = .continuous
        
        appTitle.text = result.trackName
        appCategory.text = result.primaryGenreName
    }
}
