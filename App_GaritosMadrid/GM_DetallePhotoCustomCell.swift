//
//  GM_DetallePhotoCustomCell.swift
//  App_GaritosMadrid
//
//  Created by Gustavo Gamboa on 17/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GM_DetallePhotoCustomCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myTitleLBL: UILabel!
    @IBOutlet weak var myThumbnailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
