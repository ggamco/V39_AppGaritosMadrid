//
//  GM_ComicsPosterModel.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 18/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

class GM_ComicsPosterModel {
    
    var title: String?
    var year: String?
    var imdbId: String?
    var type: String?
    var poster: String?
    
    init(pTitle: String, pYear: String, pImdbId: String, pType: String, pPoster: String) {
        self.title = pTitle
        self.year = pYear
        self.imdbId = pImdbId
        self.type = pType
        self.poster = pPoster
    }
}
