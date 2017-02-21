//
//  DishTableViewCell.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/7/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    var greenColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0)
    
    var dish: Dish? {
        didSet {
            dishNameLabel.text = dish?.name
            dishPriceLabel.text = ("฿ \(dish!.price!)")
            if dish!.vegetarian {
                let attributedName = NSMutableAttributedString(string: "\(dishNameLabel.text!) ")
                let attributedV = NSMutableAttributedString(string: "ⓥ")
                attributedV.addAttribute(NSForegroundColorAttributeName, value: greenColor, range: NSRange(location:0,length:1))
                attributedName.append(attributedV)
                dishNameLabel.attributedText = attributedName
            }

        }
    }
    
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
}
