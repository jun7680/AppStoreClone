//
//  UILabel+.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/23.
//

import UIKit

extension UILabel {
    func textLineHeight(text: String?, height: CGFloat) {
            if let text = text {
                let style = NSMutableParagraphStyle()
                style.maximumLineHeight = height
                style.minimumLineHeight = height
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .paragraphStyle: style
                ]
                    
                let attrString = NSAttributedString(string: text,
                                                    attributes: attributes)
                self.attributedText = attrString
            }
        }
}
