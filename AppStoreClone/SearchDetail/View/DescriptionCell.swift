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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    func configure(from item: Result) {
        version.text = "버전 ".appending(item.version)
        releaseNote.text = item.releaseNotes
    }
}
