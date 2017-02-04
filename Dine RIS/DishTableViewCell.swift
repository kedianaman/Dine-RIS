//
//  DishTableViewCell.swift
//  Dine RIS
//
//  Created by Naman Kedia on 1/21/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishRating: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    
    var dish: Dish! {
        didSet {
            dishImage.image = dish.image
            dishName.text = dish.name
            if dish.vegetarian == true {
                dishName.text = dishName.text! + " ☘️"
            }
            var rating = ""
            if dish.rating != nil {
                for _ in 0...dish.rating! {
                    rating.append("⭐️")
                }
            }
            dishRating.text = rating
            dishPrice.text = "\(dish.price!) ฿"
        }
    }
}
