//
//  UsersListCell.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class UsersListCell: UICollectionViewCell {
    @IBOutlet weak var imageLbl: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!

    override func awakeFromNib() {
        imageLbl.layer.masksToBounds = true
        imageLbl.setRound(withRadius: imageLbl.frame.size.width/2.0)
    }
}
