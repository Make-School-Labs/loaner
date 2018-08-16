//
//  ItemContactEditorViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit
import ContactsUI

class ItemContactEditorViewController: UIViewController {

    // MARK: - VARS
    
    var item: Item!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateUI() {
        labelTitle.text = "Contact Info"
        imageViewItem.image = item.itemImage
        labelItemTitle.text = item.itemTitle
        if item.notes.isEmpty {
            labelItemNotes.text = "No Notes"
        } else {
            labelItemNotes.text = item.notes
        }
        
        updateContactInfo()
    }
    
    func updateContactInfo() {
        if let contact = item.loanee {
            viewAddContact.isHidden = true
            stackViewContactInfo.isHidden = false
            imageViewContact.image = contact.profileImage
            labelContactName.text = contact.name
            labelContactNumber.text = contact.contactNumber ?? "No Number"
            
        } else {
            viewAddContact.isHidden = false
            stackViewContactInfo.isHidden = true
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelItemTitle: UILabel!
    @IBOutlet weak var labelItemNotes: UILabel!
    @IBOutlet weak var viewAddContact: UIView!
    @IBAction func pressAddContact(_ sender: UIButton) {
        let contactVc = CNContactPickerViewController()
        contactVc.delegate = self
        contactVc.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        
        present(contactVc, animated: true)
    }
    
    @IBOutlet weak var stackViewContactInfo: UIStackView!
    @IBOutlet weak var imageViewContact: UIImageView!
    @IBOutlet weak var labelContactName: UILabel!
    @IBOutlet weak var labelContactNumber: UILabel!
    @IBAction func pressDeleteContact(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBAction func pressSave(_ sender: UIButton) {
        
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

}

extension ItemContactEditorViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
    }
}
