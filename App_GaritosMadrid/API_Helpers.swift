//
//  API_Helpers.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//MARK: - AlertController
func muestraAlert(titleData: String, messageData: String, titleAction: String) -> UIAlertController {
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: nil))
    return alert
}

//MARK: - Politica de NULL

func dimeString(_ json: JSON, nombreKey: String) -> String {
    if let stringResult = json[nombreKey].string {
        return stringResult
    } else {
        return ""
    }
}

func dimeInt(_ json: JSON, nombreKey: String) -> Int {
    if let intResult = json[nombreKey].int {
        return intResult
    } else {
        return 0
    }
}

func dimeFloat(_ json: JSON, nombreKey: String) -> Float {
    if let floatResult = json[nombreKey].float {
        return floatResult
    } else {
        return 0.0
    }
}

func dimeDouble(_ json: JSON, nombreKey: String) -> Double {
    if let doubleResult = json[nombreKey].double {
        return doubleResult
    } else {
        return 0.0
    }
}

















