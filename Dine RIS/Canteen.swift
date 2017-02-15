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
    
    private var restaurants = [Restaurant]()
    var ref: FIRDatabaseReference!

    init() {
        ref = FIRDatabase.database().reference()
        fetchData()
    }
    
    private func fetchData() {
        ref.child("Restaurants").observe(.childAdded, with: { (snapshot) in
            if let restaurantDict = snapshot.value as? [String: AnyObject] {
                let name = restaurantDict["name"] as! String
                let cuisineType = restaurantDict["cuisineType"] as! String
                let imageName = restaurantDict["bannerImage"] as! String
                let restaurant = Restaurant(name: name, cuisineType: cuisineType, image: imageName)
                self.restaurants.append(restaurant)
            }
            for restaurant in self.restaurants {
                self.ref.child("Dishes").child(restaurant.name!).observe(.value, with: { (snapshot) in
                    let sectionDict = snapshot.value as! NSDictionary
                    //            print(snapshot)
                    let sectionTitles = sectionDict.allKeys as! [String]
                    for sectionTitle in sectionTitles {
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
                            let section = Restaurant.Section(title: sectionTitle, dishes: dishesInSection)
                            restaurant.addSection(section: section)
                        }
                    }
                }, withCancel: nil)
                print("Restaurant: \(restaurant.name!))")
                print(restaurant.numberOfDishes())
            }
        })
    }
    
}

class Restaurant {
    var name: String?
    var image: UIImage?
    var number: String?
    var cuisineType: String?
    
    struct Section {
        var title: String
        var dishes: [Dish]
        
        init(title: String, dishes: [Dish] ) {
            self.title = title
            self.dishes = dishes
        }
    }
    
    private var sections = [Section]()

    init(name: String, cuisineType: String, image: String) {
        self.name = name
        self.cuisineType = cuisineType
        self.image = UIImage(named: image)
    }
    
    func numberOfDishes() -> Int {
        var count = 0
        for section in sections {
            count = count + section.dishes.count
        }
        return count
    }
    
    func dishAt(index: IndexPath) -> Dish {
        return sections[index.section].dishes[index.row]
    }
    
    func addSection(section: Section) {
        self.sections.append(section)
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

// helper functions


