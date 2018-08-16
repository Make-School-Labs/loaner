//
//  UniversalExtentions.swift
//  iLogs - Swift
//
//  Created by Erick Sanchez on 9/26/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /**
     Adds a button with, or without an action closure with the given title
     
     - warning: the button's style is set to .default
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addDismissButton(title: String = "Dismiss") -> UIAlertController {
        return self.addButton(title: title, with: { _ in })
    }
    
    /**
     Add a button with a title, style, and action.
     
     - warning: style and action defaults to .default and an empty closure body
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addButton(title: String, style: UIAlertActionStyle = .default, with action: @escaping (UIAlertAction) -> () = {_ in}) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: style, handler: action))
        
        return self
    }
    
    /**
     Add a button with the style set to .cancel.
     
     the default action is an empty closure body
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addCancelButton(title: String = "Cancel", with action: @escaping (UIAlertAction) -> () = {_ in}) -> UIAlertController {
        return self.addButton(title: title, style: .cancel, with: action)
    }
    
    /**
     Adds a button with a cancel button after it
     
     - warning: cancel button's action is an empty closure
     
     - returns: UIAlertController
     */
    @discardableResult
    public func addConfirmationButton(title: String, style: UIAlertActionStyle = .default, with action: @escaping (UIAlertAction) -> ()) -> UIAlertController {
        return
            self.addButton(title: title, style: style, with: action)
                .addCancelButton()
    }
    
    /**
     For the given viewController, present(..) invokes viewController.present(..)
     
     - warning: viewController.present(.., animiated: true, ..doc)
     
     - returns: Discardable UIAlertController
     */
    @discardableResult
    public func present(in viewController: UIViewController, completion: (() -> ())? = nil) -> UIAlertController {
        viewController.present(self, animated: true, completion: completion)
        
        return self
    }
    
    var inputField: UITextField {
        return self.textFields!.first!
    }
}

extension UIApplication {
    
    /**
     When you open the URL built from this string, the system launches the Settings app and displays the app’s custom settings, if it has any
     */
    func openAppSettings(options: [String : Any] = [:], completion: ((Bool) -> ())? = nil) {
        let openSettingsUrl = URL(string: UIApplicationOpenSettingsURLString)!
        self.open(openSettingsUrl, options: options, completionHandler: completion)
    }
}

extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .short)
    }
}
