//
//  Canteen.swift
//  Dine RIS
//
//  Created by Naman Kedia on 1/20/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Canteen {
    
    init() {
        let databaseReference = FIRDatabase.database().reference()
        var restaurantNames = ["Redeemer Cuisine", "Thai Kitchen"]
        for name in restaurantNames {
            databaseReference.child("Restaurants").child(name).queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
                let restaurantInfo = snapshot.value! as! NSDictionary
                let name = restaurantInfo["name"] as! String
                print(name)
                let cuisineType = restaurantInfo["cuisineType"] as! String
                let imageName = restaurantInfo["bannerImage"] as! String
                let restaurant = Restaurant(name: name, cuisineType: cuisineType, image: imageName)
                self.restaurants.append(restaurant)
                
            })
        }
    }
    
    private var restaurants = [Restaurant]()
    
    func restaurantAt(index: Int) -> Restaurant? {
        if index < restaurants.count {
            return restaurants[index]
        } else {
            return nil
        }
    }
    
    func numberOfRestaurants() -> Int {
        return 2
    }
}

class Restaurant {
    var name: String?
    var image: UIImage?
    var number: String?
    var cuisineType: String?
    private var dishes = [Dish]()
    
    init(name: String, cuisineType: String, image: String) {
        self.name = name
        self.cuisineType = cuisineType
        self.image = UIImage(named: image)
    }
    
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
    var price: Int?
    var image: UIImage?
    var vegetarian = false
    
    init(name: String, price: Int, vegetarian: Bool) {
        self.name = name
        self.price = price
        self.vegetarian = vegetarian
    }
}
