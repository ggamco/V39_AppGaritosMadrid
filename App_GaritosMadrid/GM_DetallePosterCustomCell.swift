//
//  GM_DetallePosterCustomCell.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 18/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GM_DetallePosterCustomCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPoster: UIImageView!
    
    @IBOutlet weak var myTituloPoster: UILabel!
    @IBOutlet weak var myYearPoster: UILabel!
    @IBOutlet weak var myIdPoster: UILabel!
    @IBOutlet weak var myTipoPoster: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
