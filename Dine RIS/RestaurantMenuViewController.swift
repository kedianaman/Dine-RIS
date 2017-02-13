//
//  RestaurantMenuViewController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/5/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RestaurantMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    var restaurantList = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()

        fetchRestaurants()
    }
    
    func fetchRestaurants() {

        refHandle = ref.child("Restaurants").observe(.childAdded, with: { (snapshot) in
            if let restaurantDict = snapshot.value as? [String: AnyObject] {
                
                let name = restaurantDict["name"] as! String
                let cuisineType = restaurantDict["cuisineType"] as! String
                let imageName = restaurantDict["bannerImage"] as! String
                let restaurant = Restaurant(name: name, cuisineType: cuisineType, image: imageName)
                self.restaurantList.append(restaurant)
                self.restaurantTableView.reloadData()
                
            }
        })
        
    }
    
    //TableView Delegate and DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCellIdentifier", for: indexPath) as! RestaurantTableViewCell
        let restaurant = restaurantList[indexPath.row]
        restaurantCell.restaurantNameLabel.text = restaurant.name
        restaurantCell.restaurantTypeSubtitle.text = restaurant.cuisineType
        return restaurantCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RestaurantDishesSegueIdentifier", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let restaurantViewController = segue.destination as? RestaurantDishesViewController {
            let index = sender as! Int
            restaurantViewController.restaurant = restaurantList[index]
        }
    }

}
