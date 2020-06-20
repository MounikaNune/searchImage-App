//
//  ImageCollectionViewController+API.swift
//  Image_Search
//
//  Created by Admin on 6/18/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import Foundation
import UIKit

extension ImageCollectionViewController {
    
    // MARK: - SearchBar Delegate Methods
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.searchTextField.clearButtonMode = .never
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if let searchItem = searchBar.text {
            getImagesFromSearchText(searchItem)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        self.numberOfItems = 0
        self.imageCollectionView.reloadData()
    }
    
    // MARK: - API call
    
    /**
     This function is used to get the images from the search text
     
     - parameter searchString: search text entered by the user
     
     */
    
    func getImagesFromSearchText(_ searchString: String) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=06d56a220ad13f7104237d57ace4ec86&format=json&nojsoncallback=1&safe_search=1&text=" + searchString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            do {
                if let data = data {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        if let photos = jsonData["photos"] as? NSDictionary {
                            if let photoList = photos["photo"] as? NSArray {
                                self.numberOfItems = photoList.count
                                self.imageArray = photoList
                                
                                DispatchQueue.main.async {
                                    self.imageCollectionView.reloadData()
                                }
                                
                            }
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
