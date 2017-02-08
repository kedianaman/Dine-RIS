//
//  RestaurantDishesViewController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/6/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RestaurantDishesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    var restaurant: Restaurant!
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    struct Section {
        var title: String
        var dishes: [Dish]
        
        init(title: String, dishes: [Dish] ) {
            self.title = title
            self.dishes = dishes
        }
    }
    
    var sectionTitles = [String]()
    var sections = [Section]()
    var dishes = [Dish]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        self.navigationController?.navigationBar.isHidden = true
        self.restaurantNameLabel.text = restaurant.name
        self.cuisineTypeLabel.text = restaurant.cuisineType
        fetchDishes()
    }
    
    func fetchDishes() {
        refHandle = ref.child("Dishes").child(restaurant.name!).observe(.value, with: { (snapshot) in
            let sectionDict = snapshot.value as! NSDictionary
            print(snapshot)
            self.sectionTitles = sectionDict.allKeys as! [String]
            print(self.sectionTitles)
            for sectionTitle in self.sectionTitles {
                self.ref.child("Dishes").child(self.restaurant.name!).child(sectionTitle).observe(.childAdded, with: { (snapshot) in
                    
                    let dishesDict = snapshot.value as! [String: Any]
                    let dishName = dishesDict["dishName"] as! String
                    let dishPrice = dishesDict["dishPrice"] as! Int
                    let vegetarian = dishesDict["vegetarian"] as! Bool
                    let dish = Dish(name: dishName, price: dishPrice, vegetarian: vegetarian)
                    self.dishes.append(dish)
                    self.dishesTableView.reloadData()
                }, withCancel: nil)
//                self.sections.append(Section(title: sectionTitle, dishes: self.dishes))
            }
            self.dishesTableView.reloadData()
        }, withCancel: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishesCellIdentifier") as! DishTableViewCell
        cell.dish = dishes[indexPath.row]
        return cell
    }
    

}
