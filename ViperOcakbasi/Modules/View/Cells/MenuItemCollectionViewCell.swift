//
//  MenuItemCollectionViewCell.swift
//  ViperOcakbasi
//
//  Created by VAROL AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import UIKit
import Kingfisher
class MenuItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(menuItem: MenuItem){
        self.menuItemLabel.text = menuItem.name
        
    }
}
