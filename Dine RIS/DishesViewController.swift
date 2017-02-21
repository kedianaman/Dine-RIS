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

class DishesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    var sections = [Section]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        self.restaurantNameLabel.text = restaurant.name
        self.cuisineTypeLabel.text = restaurant.cuisineType
        dishesTableView.rowHeight = UITableViewAutomaticDimension
        dishesTableView.estimatedRowHeight = 100
        fetchDishes()
    }
    
    func fetchDishes() {
        refHandle = ref.child("Dishes").child(restaurant.name!).observe(.value, with: { (snapshot) in
            for section in snapshot.children {
                if let section = section as? FIRDataSnapshot {
                    let sectionTitle = section.key
                    let sectionsSnap = snapshot.childSnapshot(forPath: sectionTitle)
                    var dishesInSection = [Dish]()
                    if let dishesSnap = sectionsSnap.children.allObjects as? [FIRDataSnapshot] {
                        for dish in dishesSnap {
                            let dishInfo = dish.value as! [String:Any]
                            let dishName = dishInfo["dishName"] as! String
                            let dishPrice = dishInfo["dishPrice"] as! Int
                            let vegetarian = dishInfo["vegetarian"] as! Bool
                            let dish = Dish(name: dishName, price: dishPrice, vegetarian: vegetarian)
                            dishesInSection.append(dish)
                        }
                        let section = Section(title: sectionTitle, dishes: dishesInSection)
                        self.sections.append(section)
                    }
                }
            }
        self.dishesTableView.reloadData()
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.dishes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishesCellIdentifier") as! DishTableViewCell
        let dishes = sections[indexPath.section].dishes
        cell.dish = dishes[indexPath.row]
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02)
        return cell
    }
    

}
