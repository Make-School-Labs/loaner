//
//  ItemNotificationStack.swift
//  loaner
//
//  Created by Erick Sanchez on 8/16/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UserNotifications

class ItemNotificationStack: NotificationService {
    
    func createNotification(for item: Item) {
        guard
            let returnDate = item.returnDate,
            let loanee = item.loanee?.name else {
                return
        }
        
        let notificationBody =
        """
        The return date for \(item.itemTitle) is due! Contact \(loanee) to get your item back.
        """
        let content = UserNotificationContent(title: "Return Date Due", body: notificationBody, categoryId: "return_date_due")
        
        let returnDateCompoents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: returnDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: returnDateCompoents, repeats: false)
        
        let notificationId = "\(item.itemTitle)-\(loanee)"
        scheduleNotification(content: content, trigger: trigger, notificationIdentifier: notificationId)
    }
}

