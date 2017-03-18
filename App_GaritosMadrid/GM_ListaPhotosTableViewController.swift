//
//  GM_ListaPhotosTableViewController.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD

class GM_ListaPhotosTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var arrayPhotos : [GM_PhotosModel] = []
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var myExtraBTN: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - LLAMADA
        llamadaPhotos()
        
        //MARK: - MENU Lateral
        if revealViewController() != nil {
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            
            myExtraBTN.target = revealViewController()
            myExtraBTN.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //MARK: - Registro del XIB
        tableView.register(UINib(nibName: "GM_DetallePhotoCustomCell", bundle: nil), forCellReuseIdentifier: "DetallePhotoCustomCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPhotos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePhotoCustomCell", for: indexPath) as! GM_DetallePhotoCustomCell

        let model = arrayPhotos[indexPath.row]
        
        cell.myTitleLBL.text = model.title
        cell.myImageView.kf.setImage(with: URL(string: model.url!),
                                     placeholder: #imageLiteral(resourceName: "imgPlaceholder"),
                                     options: nil,
                                     progressBlock: nil,
                                     completionHandler: nil)
        cell.myThumbnailImage.kf.setImage(with: URL(string: model.thumbnailUrl!),
                                          placeholder: #imageLiteral(resourceName: "imgPlaceholder"),
                                          options: nil,
                                          progressBlock: nil,
                                          completionHandler: nil)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    //MARK: - Utils
    func llamadaPhotos() {
        let customPhotoGet = GM_ParserPhotosData()
        HUD.show(.progress)
        firstly{
            return when(resolved: customPhotoGet.getDatosPhotos())
        }.then{ _ in
            self.arrayPhotos = customPhotoGet.getParserPhotos()
        }.then{_ in
            self.tableView.reloadData()
        }.then{_ in
            HUD.hide(afterDelay: 0)
        }.catch{ error in
            self.present(muestraAlert(titleData: "Estimado usuario", messageData: "\(error.localizedDescription)", titleAction: "OK"), animated: true, completion: nil)
        }
    }

}
