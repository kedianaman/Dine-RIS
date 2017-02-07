//
//  RestaurantDishesViewController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/6/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class RestaurantDishesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
