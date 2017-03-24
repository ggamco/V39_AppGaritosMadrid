//: Playground - noun: a place where people can play

import UIKit

class Persona : NSObject, NSCoding {
    
    var nombre: String!
    var apellido: String!
    var direccion: String!
    var email: String!
    
    init(pNombre: String, pApellido: String, pDireccion: String, pEmail:String){
        self.nombre = pNombre
        self.apellido = pApellido
        self.direccion = pDireccion
        self.email = pEmail
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombreKey") as! String
        let apellido = aDecoder.decodeObject(forKey: "apellidoKey") as! String
        let direccion = aDecoder.decodeObject(forKey: "direccionKey") as! String
        let email = aDecoder.decodeObject(forKey: "emailKey") as! String
        
        self.init(pNombre: nombre, pApellido: apellido, pDireccion: direccion, pEmail:email)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nombre, forKey: "nombreKey")
        aCoder.encode(self.apellido, forKey: "apellidoKey")
        aCoder.encode(self.direccion, forKey: "direccionKey")
        aCoder.encode(self.email, forKey: "emailKey")
    }
}

var multitud = [Persona]()
multitud.append(Persona(pNombre: "Andres",
                        pApellido: "Ocampo",
                        pDireccion: "Calle povedilla 4",
                        pEmail: "info@info.com"))
multitud.append(Persona(pNombre: "Gustavo",
                        pApellido: "Gamboa",
                        pDireccion: "Calle Maldonado 23",
                        pEmail: "info@info.com"))
multitud.append(Persona(pNombre: "Marcelo",
                        pApellido: "Dorronsoro",
                        pDireccion: "Calle Fonsagrada 13",
                        pEmail: "info@info.com"))


func dataBaseUrl() -> URL? {
    
    if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
        
        let customUrl = URL(fileURLWithPath: documentDirectory)
        return customUrl.appendingPathComponent("multitud.data")
        
    } else {
        return nil
    }
    
}

func salvarInfo() {
    if let urlData = dataBaseUrl(){
        NSKeyedArchiver.archiveRootObject(multitud, toFile: urlData.path)
        print(urlData.path)
    } else {
        print("Error al guardar los datos")
    }
}

func cargarInfo(){
    if let urlData = dataBaseUrl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [Persona]{
        
        multitud = datosSalvados
        
    } else {
        print("Error al cargar datos")
    }
}

//1 ejecutamos l salvarDatos
salvarInfo()
//2 limpiamos
multitud.removeAll()
//3 cargamos
cargarInfo()

for c_persona in multitud {
    print("Nombre: \(c_persona.nombre!)")
}















