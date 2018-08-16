//
//  PrivacyUtility.swift
//  Assigned
//
//  Created by Erick Sanchez on 4/5/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UserNotifications
import EventKit

// Provides a default uialertcontroller to promot the user a message
import UIKit.UIAlertController

struct PrivacyUtility {
    
    // MARK: - Notifications
    
    struct PushNotifications {
        
//        static var isAuthorized: Bool {
//            
//        }
        
        private static var successfulHandler: (() -> ())?
        private static var failureHandler: (() -> ())?
        
        static func promptUserIfNeeded() {
            
            //ensure the user is only prompted once
            guard UserPersistanceUtility.hasShownIconBadge == false else { return }
            
            //TODO: Create Icon Badge UI
//            guard
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate?,
//                let window = appDelegate.window,
//                let vc = window.rootViewController else {
//                return debugPrint("no windows \(#function)")
//            }
            
            self.authorize()
            
//            let viewController = UIViewController()
//            viewController.view.backgroundColor = .blue
//
//            vc.present(viewController, animated: true)
            
            UserPersistanceUtility.hasShownIconBadge = true
        }
        
        /**
         checks the system if this app is currently authorized to access calendars
         */
        static func authorize(successfulHandler: (() -> ())? = nil, failureHandler: (() -> ())? = nil) {
            self.successfulHandler = successfulHandler
            self.failureHandler = failureHandler
            
            self.checkIfAuthorized()
        }
        
        private static func checkIfAuthorized() {
            requestAuthorization()
        }
        
        private static func requestAuthorization() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) {
                (accessGranted, error) in
                
                // User presses yes
                if accessGranted == true {
                    DispatchQueue.main.async(execute: {
                        self.successfulHandler?()
                    })
                    
                    // User presses no
                } else {
                    DispatchQueue.main.async(execute: {
                        self.failureHandler?()
                    })
                }
            }
        }
        
        /**
         <#Lorem ipsum dolor sit amet.#>
         
         - parameter openedLinkCompleition: Provide a value for this parameter if you want to be informed of the success or failure of opening the URL. This block is executed asynchronously on your app's main thread.
         
         - returns: <#Sed do eiusmod tempor.#>
         */
        static func promptAlert(in viewController: UIViewController, with alertStyle: UIAlertControllerStyle, openedLinkCompleition: ((Bool) -> ())? = nil) {

            UIAlertController(title: "Access to Push Notifications", message: "Loaner needs to have permission to post push notifications to enable return date reminders. Please open the Settings app and enable Push Notifications", preferredStyle: alertStyle)
                .addConfirmationButton(title: "Open Settings", with: { (action) in

                    // url to open settings
                    UIApplication.shared.openAppSettings(completion: openedLinkCompleition)
                })
                .present(in: viewController)
        }
    }
}
