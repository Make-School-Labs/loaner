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
    var loanee: Loanee?
}

struct Loanee {
    var name: String
    var profileImage: UIImage = UIImage(named: "no profile image")!
    var contactNumber: String?
}
