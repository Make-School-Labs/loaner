//
//  ItemDetailedViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ItemDetailedViewController: UIViewController {

    // MARK: - VARS
    
    var item: Item!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelItemTitle: UILabel!
    @IBOutlet weak var imageViewContact: UIImageView!
    @IBOutlet weak var labelLoaneeName: UILabel!
    @IBAction func pressContactLoanee(_ sender: UIButton) {
        
    }
    @IBOutlet weak var labelNotes: UILabel!
    @IBAction func pressMarkAsReturned(_ sender: UIButton) {
        
    }
    
    // MARK: - LIFE CYCLE

}
