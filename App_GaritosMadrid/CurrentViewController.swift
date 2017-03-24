//
//  CurrentViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentViewController: UIViewController {

    //MARK: - Variable locales
    var garito : GM_GaritoModel?
    var locationManager = CLLocationManager()
    var actualizandoLocalizacion = false {
        didSet{
            if actualizandoLocalizacion{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                myActivityIndicator.isHidden = false
                myActivityIndicator.startAnimating()
                myBuscarMapa.isUserInteractionEnabled = false
            }else{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                myActivityIndicator.isHidden = true
                myActivityIndicator.stopAnimating()
                myBuscarMapa.isUserInteractionEnabled = true
                myAddBTN.isEnabled = false
            }
        }
    }
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuButtonBTN: UIBarButtonItem!
    @IBOutlet weak var myBuscarMapa: UIButton!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myAddBTN: UIBarButtonItem!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - IBActions
    @IBAction func obtenerLocalizacion(_ sender: Any) {
        iniciaLocationManager()
    }
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualizandoLocalizacion = false
        
        if revealViewController() != nil {
            myMenuButtonBTN.target = revealViewController()
            myMenuButtonBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Utils
    
    func iniciaLocationManager() {
        let estadoAutorizado = CLLocationManager.authorizationStatus()
        switch estadoAutorizado {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            present(muestraAlert(titleData: "Localizacion desacivada",
                                 messageData: "Por favor, activa la localización para esta aplicación desde los ajustes del dispositivo",
                                 titleAction: "OK"),
                    animated: true,
                    completion: nil)
        default:
            if CLLocationManager.locationServicesEnabled() {
                actualizandoLocalizacion = true
                myAddBTN.isEnabled = false
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
                
                //hay que activar el user location desde el storyboard para que funcione
                let region = MKCoordinateRegionMakeWithDistance(myMapView.userLocation.coordinate, 100, 100)
                myMapView.setRegion(myMapView.regionThatFits(region), animated: true)
            }
        }
    }

}//TODO: -- FIN DE LA CLASE

//MARK: - CoreLocation Delegate
extension CurrentViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** Error en el CoreLocation ***")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else {
            return
        }
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            self.actualizandoLocalizacion = false
            
            if error == nil {
                var direccion = ""
                if let placemarkData = placemarks?.last {
                    direccion = self.stringFromPlacemark(placemarkData)
                }
                
                self.garito = GM_GaritoModel(pDireccionGarito: direccion,
                                             pLatitudGarito: latitud,
                                             pLongitudGarito: longitud,
                                             pImagenGarito: "")
                
                self.myAddBTN.isEnabled = true
            } else {
                
                self.present(muestraAlert(titleData: "Error en la localización",
                                     messageData: "Se ha producido un error mientras se buscaba tu localización. Es posible que no tengas cobertura GPS",
                                     titleAction: "OK"),
                        animated: true,
                        completion: nil)
                
            }
                        
        }
    }
    
    func stringFromPlacemark(_ placemarkData : CLPlacemark) -> String {
        
        var lineaUno = ""
        
        if let stringUno = placemarkData.thoroughfare, let stringUnoD = placemarkData.subThoroughfare{
            lineaUno += stringUno + ", " + stringUnoD
        }
        
        var lineaDos = ""
        
        if let stringUno = placemarkData.postalCode, let stringUnoD = placemarkData.locality{
            lineaDos += stringUno + ", " + stringUnoD
        }
        
        var lineaTres = ""
        
        if let stringUno = placemarkData.administrativeArea, let stringUnoD = placemarkData.country{
            lineaTres += stringUno + ", " + stringUnoD
        }
        
        return lineaUno + "\n" + lineaDos + "\n" + lineaTres
        
    }
}
















