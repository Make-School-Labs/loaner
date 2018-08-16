//
//  Item.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Item {
    var itemTitle: String
    var notes: String = ""
    var itemImage: UIImage = UIImage(named: "no item image")!
    var loanee: Loanee? = nil
    
    init(itemTitle: String) {
        self.itemTitle = itemTitle
    }
    
    init(itemTitle: String, notes: String, itemImage: UIImage, loanee: Loanee) {
        self.itemTitle = itemTitle
        self.notes = notes
        self.itemImage = itemImage
        self.loanee = loanee
    }
}

struct Loanee {
    var name: String
    var profileImage: UIImage = UIImage(named: "no profile image")!
    var contactNumber: String?
}
