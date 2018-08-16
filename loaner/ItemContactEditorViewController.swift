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
    
    var itemNotifications = ItemNotificationStack()
    
    var isShowingReturnDate: Bool {
        set {
            switchReturnDate.isOn = newValue
            
            if newValue {
                let now = Date()
                item.returnDate = now
                datePickerReturnDate.setDate(now, animated: false)
                datePickerReturnDate.alpha = 1
            } else {
                item.returnDate = nil
                datePickerReturnDate.alpha = 0
            }
        }
        get {
            return switchReturnDate.isOn
        }
    }
    
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
        
        isShowingReturnDate = item.returnDate != nil
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
        item.assignLoanee(to: nil)
        updateContactInfo()
    }
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBAction func pressSave(_ sender: UIButton) {
        
        guard item.loanee != nil else {
            let alertMissingContact = UIAlertController(
                title: "Saving New Item",
                message: "please select a contact that has a phone number",
                preferredStyle: .alert
            )
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertMissingContact.addAction(dismissAction)
            
            present(alertMissingContact, animated: true)
            
            return
        }
        
        if let returnDate = item.returnDate, returnDate <= Date() {
            
            let alertMissingContact = UIAlertController(
                title: "Saving New Item",
                message: "Return date is in the past. Please select a new return date or remove the old date.",
                preferredStyle: .alert
            )
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertMissingContact.addAction(dismissAction)
            
            present(alertMissingContact, animated: true)
            
            return
        }
        
        if item.returnDate != nil {
            itemNotifications.createNotification(for: item)
        }
        
        performSegue(withIdentifier: "unwind from saving new item", sender: nil)
    }
    
    @IBOutlet weak var switchReturnDate: UISwitch!
    @IBAction func switchChangedValue(_ sender: UISwitch) {
        if switchReturnDate.isOn {
            PrivacyUtility.PushNotifications.authorize(
                successfulHandler: {
                    
                }, failureHandler: {
                    self.isShowingReturnDate = false
                    PrivacyUtility.PushNotifications.promptAlert(in: self, with: .alert)
                }
            )
        }
        
        isShowingReturnDate = switchReturnDate.isOn
    }
    
    @IBOutlet weak var datePickerReturnDate: UIDatePicker!
    @IBAction func datePickerChangedValue(_ sender: UIDatePicker) {
        item.returnDate = datePickerReturnDate.date
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
}

extension ItemContactEditorViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        item.assignLoanee(to: contact)
        updateContactInfo()
    }
}


