//
//  ImageUtil.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromUrl(_ url: String, image: UIImage?) {
        self.image = nil
        let imageUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? String()
        
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}

/// ImageCache
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    static func test() {
        
    }
    private init() {}
}

