//
//  ViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - VARS
    
    var items: [Loan] = []

    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pat = Loanee(name: "Pat", profileImage: #imageLiteral(resourceName: "pat"), contactNumber: "70712345678")
        let sponge = Loanee(name: "Spongebob", profileImage: #imageLiteral(resourceName: "sponge"), contactNumber: "7077654341")
        let krabs = Loanee(name: "Mr. Krabs", profileImage: #imageLiteral(resourceName: "mr krabs"), contactNumber: "7071357911")
        
        let bottleLoan = Loan(itemTitle: "Water Bottle", notes: "", itemImage: #imageLiteral(resourceName: "dog"), loanee: pat)
        let phoneLoan = Loan(itemTitle: "iPhone X", notes: "", itemImage: #imageLiteral(resourceName: "hammer"), loanee: sponge)
        let gameLoan = Loan(itemTitle: "Xbox Z", notes: "", itemImage: #imageLiteral(resourceName: "star"), loanee: krabs)
        
        items = [bottleLoan, phoneLoan, gameLoan]
//        collectionView.reloadData()
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item cell", for: indexPath)
        
        return cell
    }
}

