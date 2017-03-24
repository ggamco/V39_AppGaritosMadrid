//
//  APIManagerData.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class APIManagerData: NSObject {

    static let shared = APIManagerData()
    
    var garitos : [GM_GaritoModel] = []
    
    func salvarDatos(){
        if let urlData = dataBaseurl(){
            NSKeyedArchiver.archiveRootObject(garitos, toFile: urlData.path)
        } else {
            print("Error al salvar los garitos")
        }
    }
    
    func cargarDatos(){
        if let urlData = dataBaseurl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [GM_GaritoModel]{
            garitos = datosSalvados
        } else {
            print("Error al cargar los garitos")
        }
    }
    
    func dataBaseurl() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl.appendingPathComponent("garitos.data")
            
        } else {
            return nil
        }
    }
    
    func imagenUrl() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl
            
        } else {
            return nil
        }
    }
}
