//
//  ViewController.swift
//  loaner
//
//  Created by Erick Sanchez on 8/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "unwind from back":
            print("unwind from back")
        case "unwind from mark as returned":
            print("unwind from mark as returned")
        case "unwind from trash":
            print("unwind from trash")
        default:
            break
        }
    }
}

