//
//  API_Utils.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let COLORES = Colores()
    let CONEXIONES = BaseUrl()
}

struct Colores {
    let AZUL_BARRA_NAV = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    let BLANCO_TEXTO_BARRA_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct BaseUrl {
    let BASE_URL = "https://jsonplaceholder.typicode.com/photos"
    let BASE_URL_OMDB = "https://www.omdbapi.com/?s="
}
