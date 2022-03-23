//
//  DescriptionCell.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var releaseNote: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    private var isTapMoreButton = false
    var labelHeight = CGFloat(0)
    var didTapReadMoreButton: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        let attributedTitle = NSAttributedString(string: "더 보기", attributes: attribute)
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBAction func didTapReadMore(_ sender: Any) {
        didTapReadMoreButton?()
        isTapMoreButton = true
    }
    
    func configure(from item: Result, isTapMoreButton: Bool, didTapReadMoreButton: @escaping () -> Void) {
        self.didTapReadMoreButton = didTapReadMoreButton
        version.text = "버전 ".appending(item.version)
        releaseNote.textLineHeight(text: item.releaseNotes, height: 20)
        print("line", releaseNote.numberOfLines)
        moreButton.isHidden = (item.releaseNotes?.originTextLine ?? 0) <= 2
        if isTapMoreButton {
            releaseNote.numberOfLines = 0
            moreButton.isHidden = true
        }
        labelHeight = releaseNote.frame.height - labelHeight
        releaseNote.sizeToFit()
    }
}

extension String {
    var originTextLine: Int {        
        var count = 0
        self.forEach { char in
            if char == "\n" {
                count += 1
            }
        }
        
        return count
    }
}
