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
    
    var items: [Item] = []

    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show detailed item":
                guard let detailedItemVc = segue.destination as? ItemDetailedViewController else {
                    return print("storyboard not set up correctly")
                }
                
                guard
                    let collectionViewCell = sender as? UICollectionViewCell,
                    let indexPath = collectionView.indexPath(for: collectionViewCell) else {
                        return print("'show detailed item' was performed by a non-collection view cell")
                }
                
                let selectedItem = items[indexPath.row]
                detailedItemVc.item = selectedItem
            case "show new item":
                guard let itemEditorVc = segue.destination as? ItemEditorViewController else {
                    return print("storyboard not set up correctly")
                }
                
                let newItem = createNewItem()
                itemEditorVc.item = newItem
            default: break
            }
        }
    }
    
    func createNewItem() -> Item {
        return Item(itemTitle: "Untitled Item")
    }
    
    func add(item: Item) {
        items.insert(item, at: 0)
        collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    func markItemAsReturned(at index: Int) {
        //TODO: archive returned items instead of deleting them
        deleteItem(at: index)
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
        collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "unwind from back":
            break
        case "unwind from trash":
            guard
                let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
                let selectedItemIndexPath = selectedIndexPaths.first else {
                    return
            }
            
            deleteItem(at: selectedItemIndexPath.row)
        case "unwind from mark as returned":
            guard
                let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
                let selectedItemIndexPath = selectedIndexPaths.first else {
                    return
            }
            
            markItemAsReturned(at: selectedItemIndexPath.row)
        default:
            break
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dummy data
        let pat = Loanee(name: "Pat", profileImage: #imageLiteral(resourceName: "pat"), contactNumber: "70712345678")
        let sponge = Loanee(name: "Spongebob", profileImage: #imageLiteral(resourceName: "sponge"), contactNumber: "7077654341")
        let krabs = Loanee(name: "Mr. Krabs", profileImage: #imageLiteral(resourceName: "mr krabs"), contactNumber: "7071357911")
        
        let bottleLoan = Item(itemTitle: "Water Bottle", notes: "", itemImage: #imageLiteral(resourceName: "dog"), loanee: pat)
        let phoneLoan = Item(itemTitle: "iPhone X", notes: "", itemImage: #imageLiteral(resourceName: "hammer"), loanee: sponge)
        let gameLoan = Item(itemTitle: "Xbox Z", notes: "", itemImage: #imageLiteral(resourceName: "star"), loanee: krabs)
        
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
        
    }
}

