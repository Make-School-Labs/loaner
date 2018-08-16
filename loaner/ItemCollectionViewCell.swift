//
//  ItemCollectionViewCell.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelReturnDate: UILabel!
    
    func configure(_ item: Item) {
        labelTitle.text = item.itemTitle
        imageView.image = item.itemImage
        
        if let returnDate = item.returnDate {
            labelReturnDate.text = returnDate.stringValue
        } else {
            labelReturnDate.text = nil
        }
    }
}
