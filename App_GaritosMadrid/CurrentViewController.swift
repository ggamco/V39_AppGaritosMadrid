//
//  CurrentViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit

class CurrentViewController: UIViewController {

    
    @IBOutlet weak var myMenuButtonBTN: UIBarButtonItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

