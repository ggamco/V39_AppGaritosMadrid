//
//  DetalleGaritoViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class DetalleGaritoViewController: UIViewController {

    //MARK: - Variables Locales
    var garito: GM_GaritoModel?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageViewPicker: UIImageView!
    @IBOutlet weak var myLatitudLB: UILabel!
    @IBOutlet weak var myLongitudLB: UILabel!
    @IBOutlet weak var myDireccionLB: UILabel!
    @IBOutlet weak var mySalvarDatosBTN: UIBarButtonItem!
    
    
    //MARK: - IBActions
    @IBAction func cerrarVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func salvarDatos(_ sender: Any) {
        
        
        
    }
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageViewPicker.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImageViewPicker.addGestureRecognizer(tapGR)

        configuredLabels()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Utils
    func configuredLabels(){
        myLatitudLB.text = String(format: "%.8f", (garito?.coordinate.latitude)!)
        myLongitudLB.text = String(format: "%.8f", (garito?.coordinate.longitude)!)
        myDireccionLB.text = garito?.direccionGarito
    }
    

}//TODO: - FIN DE LA CLASE

extension DetalleGaritoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickerPhoto(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        } else {
            muestraLibreriaFotos()
        }
        
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFoto = UIAlertAction(title: "Toma foto", style: .default) { _ in
            
            self.muestraCamaraDispositivo()
            
        }
        let seleccionaFoto = UIAlertAction(title: "Selecciona desde Fotos", style: .default) { _ in
            
            self.muestraLibreriaFotos()
            
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFoto)
        alertVC.addAction(seleccionaFoto)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraDispositivo(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImageViewPicker.image = imageData
            mySalvarDatosBTN.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
}













