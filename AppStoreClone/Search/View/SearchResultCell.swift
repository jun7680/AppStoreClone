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
    
    lazy var screenShot1 = createUIImageView()
    lazy var screenShot2 = createUIImageView()
    lazy var screenShot3 = createUIImageView()
    
    func createUIImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleToFill
        
        return imageView
    }
    
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
        screenShot1.image = nil
        screenShot2.image = nil
        screenShot3.image = nil
    }
    
    private func setupView() {
        addSubview(ratingView)
        screenShotViews.addArrangedSubview(screenShot1)
        screenShotViews.addArrangedSubview(screenShot2)
        screenShotViews.addArrangedSubview(screenShot3)
        
        NSLayoutConstraint.activate([
            ratingView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 5),
            ratingView.widthAnchor.constraint(equalToConstant: 120),
            ratingView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(from result: Result) {
        let titleImageKey = NSString(string: result.artworkUrl512)
        if let cacheImage = ImageCache.shared.object(forKey: titleImageKey) {
            titleImage.image = cacheImage
        } else {
            titleImage.imageFromUrl(result.artworkUrl512, image: UIImage())
        }
        
        screenShot1.imageFromUrl(result.screenshotUrls[0], image: UIImage())
        if result.screenshotUrls.count > 1 {
            screenShot2.imageFromUrl(result.screenshotUrls[1], image: UIImage())
        }
        
        if result.screenshotUrls.count > 2 {
            screenShot3.imageFromUrl(result.screenshotUrls[2], image: UIImage())
        }
        ratingView.rating = result.averageUserRating
        ratingView.text = result.userRatingCount.userCountingFormat
        title.text = result.trackName
        category.text = result.primaryGenreName
    }
}
