//
//  GM_ParserPosterData.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 18/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit
import Alamofire
import SwiftyJSON

class GM_ParserPosterData {
    
    var jsonDataPosterImdb : JSON?
    
    func getDataImdb(_ idObjeto: String, idNumero: String) -> Promise<JSON> {
        let customRequest = URLRequest(url: URL(string: CONSTANTES.CONEXIONES.BASE_URL_OMDB + idObjeto + "&page=" + idNumero)!)
        
        return Alamofire.request(customRequest).responseJSON().then{ (data) -> JSON in
            self.jsonDataPosterImdb = JSON(data)
            return self.jsonDataPosterImdb!
        }
    }
    
    func getParserImdb() -> [GM_ComicsPosterModel] {
        var arrayDatosImdb = [GM_ComicsPosterModel]()
        for item in jsonDataPosterImdb!["Search"] {
            let dataModel = GM_ComicsPosterModel(pTitle: dimeString(item.1, nombreKey: "Title"),
                                                 pYear: dimeString(item.1, nombreKey: "Year"),
                                                 pImdbId: dimeString(item.1, nombreKey: "imdbID"),
                                                 pType: dimeString(item.1, nombreKey: "Type"),
                                                 pPoster: dimeString(item.1, nombreKey: "Poster"))
            arrayDatosImdb.append(dataModel)
        }
        
        return arrayDatosImdb
    }
    
    
    
    
    
    
}
