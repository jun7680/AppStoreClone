//
//  ScreenShotCell.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
    
    @IBOutlet weak var screenShot: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageviewConfigure()
    }
    func imageviewConfigure() {
        screenShot.clipsToBounds = true
        screenShot.layer.cornerRadius = 12
        screenShot.layer.borderWidth = 0.5
        screenShot.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    }
    func setScreenShot(from url: String) {
        
        screenShot.imageFromUrl(url, image: UIImage())
    }
}
