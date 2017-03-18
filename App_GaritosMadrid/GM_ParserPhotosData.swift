//
//  GM_ParserPhotosData.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class GM_ParserPhotosData {
    
    var jsonDataPhotos: JSON?
    
    func getDatosPhotos() -> Promise<JSON> {
        
        let customRequest = URLRequest(url: URL(string: CONSTANTES.CONEXIONES.BASE_URL)!)
        
        return Alamofire.request(customRequest).responseJSON().then(execute: { (data) -> JSON in
            self.jsonDataPhotos = JSON(data)
            return self.jsonDataPhotos!
        })
    }
    
    func getParserPhotos() -> [GM_PhotosModel] {
        
        var arrayPhotosModel : [GM_PhotosModel] = []
        
        for item in jsonDataPhotos! {
            let photoModel = GM_PhotosModel(albumId: dimeInt(item.1, nombreKey: "albumId"),
                                            id: dimeInt(item.1, nombreKey: "id"),
                                            title: dimeString(item.1, nombreKey: "title"),
                                            url: dimeString(item.1, nombreKey: "url"),
                                            thumbnailUrl: dimeString(item.1, nombreKey: "thumbnailUrl"))
            arrayPhotosModel.append(photoModel)
        }
        
        return arrayPhotosModel
    }
    
}
