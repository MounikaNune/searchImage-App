//
//  ImageView+Extension.swift
//  Image_Search
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /**
    This function is used for image caching 
    
    - parameter urlString: source from where we get image
     
    */
    
    func loadImage(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
        
    }
}
