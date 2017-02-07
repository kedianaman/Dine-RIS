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

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        self.navigationController?.navigationBar.isHidden = true
        self.restaurantNameLabel.text = restaurant.name
        self.cuisineTypeLabel.text = restaurant.cuisineType
        fetchDishes()
    }
    
    func fetchDishes() {
        refHandle = ref.child("Dishes").child(restaurant.name!).observe(.childAdded, with: { (snapshot) in
            let dishesDict = snapshot.value as! NSDictionary
            self.sectionTitles = dishesDict.allKeys as! [String]
        }, withCancel: nil)
        
        for sectionTitle in sectionTitles {
            ref.child("Dishes").child(restaurant.name!).child(sectionTitle).observe(.childAdded, with: { (snapshot) in
                print(snapshot)
            }, withCancel: nil)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DishesCellIdentifier")
        cell.textLabel?.text = "Dish Name"
        cell.detailTextLabel?.text = "45"
        return cell
    }
    

}
