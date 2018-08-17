//
//  ItemEditorViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/17/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ItemEditorViewController: UIViewController {

    var item: Item!
    
    func updateUI() {
        labelTitle.text = "Item Details"
        imageViewItem.image = item.itemImage
        textFieldItemTitle.text = item.itemTitle
        if item.notes.isEmpty {
            buttonNotes.setTitle("Add Notes", for: .normal)
        } else {
            buttonNotes.setTitle(item.notes, for: .normal)
        }
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBAction func pressLeftButton(_ sender: Any) {
        //TODO: confirm with user if they're sure they want to cancel adding a new item
    }
    
    @IBAction func pressItemImage(_ sender: Any) {
        //TODO: present the photo library picker to pick an image for the item
    }
    
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var textFieldItemTitle: UITextField!
    @IBOutlet weak var buttonNotes: UIButton!
    @IBAction func pressNotes(_ sender: Any) {
        //TODO: present a notes view controller to edit the item's notes
    }
    
    @IBAction func pressContactInfo(_ sender: Any) {
        //TODO: segue to the next step only if the user has select an image and added an item title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

}
