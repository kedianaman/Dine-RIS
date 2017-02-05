//
//  RestaurantMenuViewController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 2/5/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class RestaurantMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    var canteen: Canteen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canteen = Canteen()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(canteen.numberOfRestaurants())
        return canteen.numberOfRestaurants()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCellIdentifier", for: indexPath) as! RestaurantTableViewCell
        let restaurant = canteen.restaurantAt(index: indexPath.row)
        restaurantCell.restaurantNameLabel.text = restaurant?.name
        restaurantCell.restaurantTypeSubtitle.text = restaurant?.cuisineType
        return restaurantCell
    }

}
