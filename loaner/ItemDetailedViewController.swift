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
    
    func updateUI() {
        
        labelTitle.text = "Item Details"
        labelItemTitle.text = item.itemTitle
        imageViewItem.image = item.itemImage
        if let loanee = item.loanee {
            labelLoaneeName.text = loanee.name
            imageViewLoanee.image = loanee.profileImage
        }
        
        if item.notes.isEmpty {
            labelNotes.text = "no notes"
        } else {
            labelNotes.text = item.notes
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBAction func pressTrash(_ sender: UIButton) {
        //TODO: prompt user "are you sure?" then segue 'unwind from trash'
    }
    
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelItemTitle: UILabel!
    @IBOutlet weak var imageViewLoanee: UIImageView!
    @IBOutlet weak var labelLoaneeName: UILabel!
    @IBAction func pressContactLoanee(_ sender: UIButton) {
        //TODO: prompt the contact info
    }
    
    @IBOutlet weak var labelNotes: UILabel!
    @IBAction func pressMarkAsReturned(_ sender: UIButton) {
        //TODO: unwind from mark as returned
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

}
