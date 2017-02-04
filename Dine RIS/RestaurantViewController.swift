//
//  RestaurantViewController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 1/21/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurant: Restaurant!

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var cuisineType: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        restaurant = Restaurant()
        restaurant.name = "Redeemer Cuisine"
        restaurant.cuisineType = "Western"
        restaurant.number = "66991656320"
        restaurant.image = UIImage(named: "RedeemerBanner")
        
        let dish = Dish()
        dish.name = "Margherita"
        dish.price = 125
        dish.image = UIImage(named: "Margherita")
        dish.vegetarian = true
        restaurant.addDish(dish: dish)
        
        let dish2 = Dish()
        dish2.name = "Steamed Rice topped with Fried Pork/Chicken/Shrimps and Basil Leaves"
        dish2.price = 125
        dish2.image = UIImage(named: "Margherita")
        dish2.vegetarian = true
        restaurant.addDish(dish: dish2)
        
        let dish3 = Dish()
        dish3.name = "Margherita"
        dish3.price = 125
        dish3.image = UIImage(named: "Margherita")
        dish3.vegetarian = true
        restaurant.addDish(dish: dish3)
       
        //
        restaurantImage.image = restaurant.image
        restaurantName.text = restaurant.name
        cuisineType.text = restaurant.cuisineType

    }
    
    @IBAction func callRestaurant(_ sender: Any) {
        callNumber(phoneNumber: restaurant.number!)
        
    }
    
    
    // TableView Delegate and DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.numberOfDishes()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dishTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DishCellIdentifier", for: indexPath) as! DishTableViewCell
        dishTableViewCell.dish = restaurant.dishAt(index: indexPath.row)
        return dishTableViewCell
    }
    
    // Helper functions 
    
    private func callNumber(phoneNumber:String) { // fix function
        if let phoneCallURL:NSURL = NSURL(string:"tel://"+"\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }

}

