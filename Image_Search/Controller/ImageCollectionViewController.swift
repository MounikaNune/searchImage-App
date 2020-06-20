//
//  ImageCollectionViewController.swift
//  Image_Search
//
//  Created by Admin on 6/16/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import Foundation
import UIKit

class ImageCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
     // MARK: - IBOutlets
    
    @IBOutlet weak var searchBarItem: UISearchBar!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    var numberOfItems: Int?
    
    var imageArray: NSArray?
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        //self.definesPresentationContext = true
        self.imageCollectionView.register(UINib(nibName:"ImageCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        self.searchBarItem.delegate = self
        //imgSearch.becomeFirstResponder()
        //self.imageCollectionView.reloadData()
    }
    
    // MARK: - CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCellCollectionViewCell {
            if let downloadImages = imageArray {
                item.configure(Photo.init(json: downloadImages[indexPath.row] as! [String : Any]))
            }
            return item
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.imageCollectionView.frame.width/3.0) - 5 , height: (self.imageCollectionView.frame.height/3.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    
}
