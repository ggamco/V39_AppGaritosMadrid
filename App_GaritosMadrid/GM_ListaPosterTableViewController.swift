//
//  GM_ListaPosterTableViewController.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 18/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GM_ListaPosterTableViewController: UITableViewController {

    //MARK: - Variables Locales
    var arrayPoster : [GM_ComicsPosterModel] = []
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var myExtraBTN: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func llamadaPoster() {
        
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

        
        
        return cell
    }
    

    

}
