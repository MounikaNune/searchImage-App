//
//  ImageCellCollectionViewCell.swift
//  Image_Search
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import UIKit

class ImageCellCollectionViewCell: UICollectionViewCell {
    
      // MARK: - IBOutlets
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
       This function is used for configuring image in to collection view cell
       
       - parameter imageData: Data of the item that needs to be configured
        
       */
    func configure(_ imageData: Photo) {
        if let imageUrl = imageData.urlString {
            self.itemImageView?.loadImage(urlString: imageUrl)
        }
    }
    
}
