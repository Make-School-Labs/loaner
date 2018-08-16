//
//  ItemEditorViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ItemEditorViewController: UIViewController {

    // MARK: - VARS
    
    var item: Item!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show item notes":
                guard let itemNotesVc = segue.destination as? ItemNotesViewController else {
                    return print("storyboard not set up correctly")
                }
                
                itemNotesVc.body = item.notes
            case "show contact info":
                guard let itemContactVc = segue.destination as? ItemContactEditorViewController else {
                    return print("storyboard not set up correctly")
                }
                
                itemContactVc.item = item
            default: break
            }
        }
    }
    
    func updateUI() {
        labelTitle.text = "Item Details"
        imageViewItem.image = item.itemImage
        if item.itemImage == UIImage(named: "no item image") {
            buttonSaveToLibrary.alpha = 0
        } else {
            buttonSaveToLibrary.alpha = 1
        }
        textFieldItemTitle.text = item.itemTitle
        if item.notes.isEmpty {
            buttonNotes.setTitle("Add Notes", for: .normal)
        } else {
            buttonNotes.setTitle(item.notes, for: .normal)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: Any?) {
        if error == nil {
            let okSavingToPhotoLibraryAlert = UIAlertController(title: "Saving to Camera Roll", message: "successfully saved selected picture to camera roll", preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            okSavingToPhotoLibraryAlert.addAction(dismissAction)
            
            present(okSavingToPhotoLibraryAlert, animated: true)
        } else {
            let errorAlert = UIAlertController(title: "Saving to Camera Roll", message: "something went wrong: \(error!.localizedDescription)", preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            errorAlert.addAction(dismissAction)
            
            present(errorAlert, animated: true)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func unwindToItemEditor(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "unwind from notes":
            guard let itemNotesVc = segue.source as? ItemNotesViewController else {
                return print("storyboard not set up correctly")
            }
            
            item.notes = itemNotesVc.body
            
            updateUI()
        case "unwind from contact info":
            guard let itemContactVc = segue.source as? ItemContactEditorViewController else {
                return print("storyboard not set up correctly")
            }
            
            item = itemContactVc.item
        default:
            break
        }
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBAction func pressLeftButton(_ sender: Any) {
        let alertDiscardChanges = UIAlertController(
            title: nil,
            message: "Are you sure you want to cancel these changes?",
            preferredStyle: .actionSheet
        )
        
        let actionDiscardChanges = UIAlertAction(title: "Discard Changes", style: .destructive) { (_) in
            self.performSegue(withIdentifier: "unwind from cancel", sender: nil)
        }
        alertDiscardChanges.addAction(actionDiscardChanges)
        
        let actionCancel = UIAlertAction(title: "Continue Editing", style: .cancel)
        alertDiscardChanges.addAction(actionCancel)
        
        present(alertDiscardChanges, animated: true)
    }
    
    @IBAction func pressItemImage(_ sender: Any) {
        let photoSourceAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            let imagePickerVc = UIImagePickerController()
            imagePickerVc.delegate = self
            imagePickerVc.allowsEditing = false
            imagePickerVc.sourceType = .savedPhotosAlbum
            
            self.present(imagePickerVc, animated: true)
        }
        photoSourceAlert.addAction(photoLibraryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                let imagePickerVc = UIImagePickerController()
                imagePickerVc.delegate = self
                imagePickerVc.allowsEditing = false
                imagePickerVc.sourceType = .camera
                
                self.present(imagePickerVc, animated: true)
            }
            photoSourceAlert.addAction(cameraAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        photoSourceAlert.addAction(cancelAction)
        
        present(photoSourceAlert, animated: true)
    }
    
    @IBOutlet weak var buttonSaveToLibrary: UIButton!
    @IBAction func pressSaveToLibrary(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(item.itemImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var textFieldItemTitle: UITextField!
    @IBOutlet weak var buttonNotes: UIButton!
    @IBAction func pressNotes(_ sender: Any) {
        
    }
    
    @IBAction func pressContactInfo(_ sender: Any) {
        if item.itemImage != UIImage(named: "no item image") {
            performSegue(withIdentifier: "show contact info", sender: nil)
        } else {
            let alertMissingPhoto = UIAlertController(
                title: "Saving New Item",
                message: "please select a picture for this new item",
                preferredStyle: .alert
            )
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertMissingPhoto.addAction(dismissAction)
            
            present(alertMissingPhoto, animated: true)
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

}

extension ItemEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
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

extension ItemEditorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField === textFieldItemTitle else {
            return
        }
        
        item.itemTitle = textField.text ?? ""
    }
}
