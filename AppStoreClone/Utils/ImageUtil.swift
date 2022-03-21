//
//  ImageUtil.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import Foundation
import UIKit

extension String {
    var image: UIImage? {
        let url = URL(string: self)!
        guard let data = try? Data(contentsOf: url) else { return UIImage() }
        
        return UIImage(data: data)
    }
}

/// ImageCache
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    static func test() {
        
    }
    private init() {}
}

