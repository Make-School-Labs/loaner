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
        
        //dummy data
        let pat = Loanee(name: "Pat", profileImage: #imageLiteral(resourceName: "pat"), contactNumber: "70712345678")
        let sponge = Loanee(name: "Spongebob", profileImage: #imageLiteral(resourceName: "sponge"), contactNumber: "7077654341")
        let krabs = Loanee(name: "Mr. Krabs", profileImage: #imageLiteral(resourceName: "mr krabs"), contactNumber: "7071357911")
        
        let bottleLoan = Loan(itemTitle: "Water Bottle", notes: "", itemImage: #imageLiteral(resourceName: "dog"), loanee: pat)
        let phoneLoan = Loan(itemTitle: "iPhone X", notes: "", itemImage: #imageLiteral(resourceName: "hammer"), loanee: sponge)
        let gameLoan = Loan(itemTitle: "Xbox Z", notes: "", itemImage: #imageLiteral(resourceName: "star"), loanee: krabs)
        
        items = [bottleLoan, phoneLoan, gameLoan]
        
        //set up collection view layout
        let flow = UICollectionViewFlowLayout()
        let screenSize = view.bounds.size
        let horizontalPadding: CGFloat = 8
        let verticalPadding: CGFloat = 12
        flow.itemSize = CGSize(width: screenSize.width / 2 - horizontalPadding * 2, height: screenSize.width / 2 - verticalPadding * 2)
        flow.sectionInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        collectionView.collectionViewLayout = flow
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item cell", for: indexPath) as! ItemCollectionViewCell
        
        let item = items[indexPath.row]
        cell.configure(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

