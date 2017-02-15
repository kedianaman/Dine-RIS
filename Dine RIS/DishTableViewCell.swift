//
//  DishTableViewCell.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/7/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    var dish: Dish? {
        didSet {
            dishNameLabel.text = dish?.name
            dishPriceLabel.text = ("฿ \(dish!.price!)")
            if dish!.vegetarian {
                dishNameLabel.text?.append(" ☘️")
            }

        }
    }
    
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
}
