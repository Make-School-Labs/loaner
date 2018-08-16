//
//  UserPersistenceUtitlity.swift
//  Assigned
//
//  Created by Erick Sanchez on 6/20/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

enum UserPersistanceUtility {
    
    static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static func resetUserPersistence() {
        hasShownIconBadge = false
    }
    
    private static let HAS_SHOWN_ICONBADGEUI = "HAS_SHOWN_ICONBADGEUI"
    
    static var hasShownIconBadge: Bool {
        set {
            userDefaults.set(newValue, forKey: HAS_SHOWN_ICONBADGEUI)
        }
        get {
            return userDefaults.bool(forKey: HAS_SHOWN_ICONBADGEUI)
        }
    }
}
