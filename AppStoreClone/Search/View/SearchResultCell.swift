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
    @IBOutlet weak var screenShotVies: UIStackView!
    
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
        titleImage.image = result.artworkUrl512.image
    }
}
