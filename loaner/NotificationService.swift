//
//  NotificationService.swift
//  Assigned
//
//  Created by Erick Sanchez on 6/12/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UserNotifications

/**
 abstract class
 */
class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    
    private var userNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - INITs
    
    //TODO: make private
    override init() {
        super.init()
        
        // append any new categories
        userNotificationCenter.getNotificationCategories { [weak self] (currentCategories) in
            guard let unwrappedSelf = self else { return }
            
            let appendingCategories = unwrappedSelf.registerCategories()
            unwrappedSelf.userNotificationCenter.setNotificationCategories(currentCategories.union(appendingCategories))
        }
        
        userNotificationCenter.delegate = self
    }
    
    // MARK: - RETURN VALUES
    
    /**
     set up new categories by override and returning new notification categories
     
     - return: categories here will be unioned by `getNotificationCategories(..)` async
     */
    func registerCategories() -> Set<UNNotificationCategory> { return [] }
    
    // MARK: - METHODS
    
    final func scheduleNotification(
        content: UNNotificationContent,
        trigger: UNNotificationTrigger!,
        notificationIdentifier: String,
        completionHandler: ((Error?) -> Void)? = nil)                           {
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        userNotificationCenter.add(request, withCompletionHandler: completionHandler)
    }
    
    /**
     posts the given notification now
     */
    final func postNotification(
        content: UNNotificationContent,
        notificationIdentifier: String,
        completionHandler: ((Error?) -> Void)? = nil)                           {
        self.scheduleNotification(content: content, trigger: nil, notificationIdentifier: notificationIdentifier)
    }
    
    /**
     The method will be called on the delegate only if the application is in the foreground.
     If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented.
     */
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        fatalError("not implemented")
//    }
    
    /**
     the method will be called when the user selects a notification
     */
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
//        fatalError("not implemented")
//    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

typealias UserNotificationContent = UNMutableNotificationContent

extension UserNotificationContent {
    
    /** helper init */
    convenience init(
        title: String,
        subtitle: String = "",
        body: String,
        categoryId: String,
        sound: UNNotificationSound = UNNotificationSound.default(),
        badge: Int? = nil
        ) {
        self.init()
        
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.categoryIdentifier = categoryId
        self.sound = sound
        self.badge = badge as NSNumber?
    }
}
