//
//  GM_GaritoModel.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import MapKit

class GM_GaritoModel: NSObject{
    
    var direccionGarito: String?
    var latitudGarito: Double?
    var longitudGarito: Double?
    var imagenGarito: String?
    
    init(pDireccionGarito: String, pLatitudGarito: Double, pLongitudGarito: Double, pImagenGarito: String){
        self.direccionGarito = pDireccionGarito
        self.latitudGarito = pLatitudGarito
        self.longitudGarito = pLongitudGarito
        self.imagenGarito = pImagenGarito
    }
    
}

extension GM_GaritoModel : MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: latitudGarito!, longitude: longitudGarito!)
        }
    }
    
    
    // Title and subtitle for use by selection UI.
    var title: String? {
        get {
            return "Garito de Madrid"
        }
    }
    
    var subtitle: String? {
        get {
            return direccionGarito?.replacingOccurrences(of: "\n", with: "")
        }
    }
}
