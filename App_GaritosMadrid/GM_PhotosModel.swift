//
//  GM_PhotosModel.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

class GM_PhotosModel {
    
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
}
