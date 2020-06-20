//
//  Photo.swift
//  Image_Search
//
//  Created by Admin on 6/18/20.
//  Copyright © 2020 Rehlat. All rights reserved.
//

import Foundation

public struct Photo: Decodable {
    
    public var title: String?
    public var farm: Int?
    public var id: String?
    public var server: String?
    public var secret: String?
    public var urlString: String?
    
    public init(json: [String: Any]) {
        self.title = json["title"] as? String
        self.farm = json["farm"] as? Int
        self.id = json["id"] as? String
        self.server = json["server"] as? String
        self.secret = json["secret"] as? String
        if let farm = self.farm, let id = self.id, let server = self.server, let secret = self.secret {
            self.urlString = "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        }
        
    }
    
}
