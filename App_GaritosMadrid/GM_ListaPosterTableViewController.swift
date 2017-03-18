//
//  GM_ListaPosterTableViewController.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 18/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD

class GM_ListaPosterTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var arrayPoster : [GM_ComicsPosterModel] = []
    var customRefreshControl = UIRefreshControl()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var myExtraBTN: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customRefreshControl.attributedTitle = NSAttributedString(string: "Arrastra para Actualizar")
        customRefreshControl.addTarget(self, action: #selector(self.recargando), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
        
        //MARK: - LLAMADA
        llamadaPoster()
        
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
        tableView.register(UINib(nibName: "GM_DetallePosterCustomCell", bundle: nil), forCellReuseIdentifier: "DetallePosterCustomCell")
        
    }
    
    //MARK: - Utiles
    func recargando() {
        llamadaPoster()
        customRefreshControl.endRefreshing()
    }
    
    func llamadaPoster() {
        //carga un nuevo servicioRest
        let randomNumero = Int(arc4random_uniform(4))
        let personajes = ["Batman", "Flash", "Hulk", "Superman"]
        
        let dataPoster = GM_ParserPosterData()
        
        HUD.show(.progress)
        firstly{
            return when(resolved: dataPoster.getDataImdb(personajes[randomNumero], idNumero: String(randomNumero+1)))
        }.then{_ in
            self.arrayPoster = dataPoster.getParserImdb()
        }.then{_ in
            self.tableView.reloadData()
        }.then{_ in
            HUD.hide(afterDelay: 0)
        }.catch{ error in
            self.present(muestraAlert(titleData: "Estimado Usuario", messageData: "\(error.localizedDescription)", titleAction: "OK"), animated: true, completion: nil)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPoster.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePosterCustomCell", for: indexPath) as! GM_DetallePosterCustomCell
        
        let model = arrayPoster[indexPath.row]

        cell.myImagenPoster.kf.setImage(with: URL(string: model.poster!),
                                        placeholder: #imageLiteral(resourceName: "imgPlaceholder"),
                                        options: nil,
                                        progressBlock: nil,
                                        completionHandler: nil)
        
        cell.myTituloPoster.text = model.title
        cell.myIdPoster.text = model.imdbId
        cell.myYearPoster.text = model.year
        cell.myTipoPoster.text = model.type
        
        return cell
    }
    

    

}
