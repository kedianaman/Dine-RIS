//
//  Canteen.swift
//  Dine RIS
//
//  Created by Naman Kedia on 1/20/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import Foundation
import UIKit

class Canteen {
    private var restaurants: [Restaurant]?
    
    func restaurantAt(index: Int) -> Restaurant? {
        if restaurants != nil && index < restaurants!.count {
            return restaurants![index]
        } else {
            return nil
        }
    }
    
    func numberOfRestaurants() -> Int {
        if let restaurants = restaurants {
            return restaurants.count
        } else {
            return 0
        }
    }
}

class Restaurant {
    var name: String?
    var image: UIImage?
    var number: String?
    var cuisineType: String?
    private var dishes = [Dish]()
    
    func numberOfDishes() -> Int {
        return dishes.count
    }
    
    func dishAt(index: Int) -> Dish {
        return dishes[index]
    }
    
    func addDish(dish: Dish) {
        dishes.append(dish)
    }
}

class Dish {
    var name: String?
    var type: String?
    var rating: Int?
    var price: Int?
    var image: UIImage?
    var vegetarian = false
}
