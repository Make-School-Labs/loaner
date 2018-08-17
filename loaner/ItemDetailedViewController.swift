//
//  ItemDetailedViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/17/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ItemDetailedViewController: UIViewController {
    
    var item: Item!
    
    func updateUI() {
        print(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let krabs = Loanee(name: "Mr. Krabs", profileImage: #imageLiteral(resourceName: "mr krabs"), contactNumber: "7071357911")
        let bottleLoan = Item(itemTitle: "Water Bottle", notes: "", itemImage: #imageLiteral(resourceName: "plane"), loanee: krabs)

        item = bottleLoan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
}
