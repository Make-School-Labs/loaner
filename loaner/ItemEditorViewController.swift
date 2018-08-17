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
        let photoSourceAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            let imagePickerVc = UIImagePickerController()
            imagePickerVc.delegate = self
            imagePickerVc.allowsEditing = true
            imagePickerVc.sourceType = .savedPhotosAlbum
            
            self.present(imagePickerVc, animated: true)
        }
        photoSourceAlert.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        photoSourceAlert.addAction(cancelAction)
        
        present(photoSourceAlert, animated: true)
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

extension ItemEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return print("failed to get image")
        }
        
        let fixedImage = pickedImage.applyFixedOrientation
        item.itemImage = fixedImage
        
        updateUI()
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
