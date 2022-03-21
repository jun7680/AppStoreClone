//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import UIKit
import Cosmos

class SearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var installButton: UIButton!
    @IBOutlet weak var screenShotViews: UIStackView!
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    private let ratingView: CosmosView = {
       let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.starSize = 14
        view.settings.starMargin = 2
        view.settings.totalStars = 5
        view.settings.filledBorderColor = .lightGray
        view.settings.filledColor = .lightGray
        view.settings.emptyBorderColor = .lightGray
        view.settings.emptyColor = .white
        view.rating = 3.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingView.rating = 0
    }
    
    private func setupView() {
        addSubview(ratingView)

        NSLayoutConstraint.activate([
            ratingView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 5),
            ratingView.widthAnchor.constraint(equalToConstant: 120),
            ratingView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(from result: Result) {
        let titleImageKey = NSString(string: result.artworkUrl512 ?? String())
        let screenShot1Cache = NSString(string: result.screenshotUrls?[0] ?? String())
        let screenShot2Cache = NSString(string: result.screenshotUrls?[1] ?? String())
        let screenShot3Cache = NSString(string: result.screenshotUrls?[2] ?? String())
        
        if let cacheImage = ImageCache.shared.object(forKey: titleImageKey) {
            titleImage.image = cacheImage
        } else {
            titleImage.image = result.artworkUrl512?.image
        }
        
        if let cacheImage = ImageCache.shared.object(forKey: screenShot1Cache) {
            screenShot1.image = cacheImage
        } else {
            let image = result.screenshotUrls?[0].image ?? UIImage()
            ImageCache.shared.setObject(image, forKey: screenShot1Cache)
            screenShot1.image = image
        }
        
        if let cacheImage = ImageCache.shared.object(forKey: screenShot2Cache) {
            screenShot2.image = cacheImage
        } else {
            let image = result.screenshotUrls?[1].image ?? UIImage()
            ImageCache.shared.setObject(image, forKey: screenShot2Cache)
            screenShot2.image = image
        }
        
        if let cacheImage = ImageCache.shared.object(forKey: screenShot3Cache) {
            screenShot3.image = cacheImage
        } else {
            let image = result.screenshotUrls?[2].image ?? UIImage()
            ImageCache.shared.setObject(image, forKey: screenShot3Cache)
            screenShot3.image = image
        }
        ratingView.rating = result.averageUserRating ?? 0
        title.text = result.trackName
    }
}
