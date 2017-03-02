//
//  RestaurantTableViewCell.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/5/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeSubtitle: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        self.bannerImageView.layer.shadowOffset = CGSize(width: 0, height: 2);
        self.bannerImageView.layer.shadowRadius = 4;
        self.bannerImageView.layer.shadowOpacity = 0.5;
        self.bannerImageView.layer.shadowColor = UIColor.black.cgColor;
        self.bannerImageView.layer.shouldRasterize = true
        self.bannerImageView.layer.rasterizationScale = UIScreen.main.scale
        self.bannerImageView.layer.cornerRadius = 5.0
    }
    
}
