//
//  Util.swift
//  flockr
//
//  Created by Matheus Frozzi Alberton on 20/07/15.
//  Copyright (c) 2015 flockr. All rights reserved.
//

import UIKit

class Util {
    enum UIUserInterfaceIdiom : Int {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    static func roundedView(view: CALayer!, border: Bool, colorHex: String?, borderSize: CGFloat?, radius: CGFloat) {
        if(border == true) {
            view.borderWidth = borderSize!
            view.borderColor = hexStringToUIColor(colorHex!).CGColor
        }
        view.cornerRadius = radius
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.successor())
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }

        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    static func registerClass() {
        User.registerSubclass()
        Category.registerSubclass()
        Donation.registerSubclass()
        Needs.registerSubclass()
        Story.registerSubclass()
        Support.registerSubclass()
    }

    static func setAppUi() {
        let colorNav = UIColor(red: 137/255.0, green:88/255.0, blue:166/255.0, alpha:1.0)
        let font = UIFont(name: "HelveticaNeue-Bold", size: 16)

        if let font = font {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : Util.hexStringToUIColor("FFFFFF")]
        }

        UINavigationBar.appearance().tintColor = Util.hexStringToUIColor("FFFFFF")
        UINavigationBar.appearance().barTintColor = colorNav
        UINavigationBar.appearance().opaque = false
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)

//        UINavigationBar.appearance().clipsToBounds = true
        
        _ = UIColor(red: 55.0/255.0, green: 61.0/255.0, blue: 74.0/255.0, alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = Util.hexStringToUIColor("FFD162")
        UITabBar.appearance().translucent = true
        UITabBar.appearance().opaque = false

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.redColor()], forState: UIControlState.Selected)
    }

    static func howLongTime (date: NSDate) -> String {
        var messageAgo = ""
        
        let dateNow = NSDate()
        let userCalendar = NSCalendar.currentCalendar()
        
        let dayCalendarUnit = NSCalendarUnit(rawValue: UInt.max)
        
        let dateAgo = userCalendar.components(
            dayCalendarUnit,
            fromDate: date,
            toDate: dateNow,
            options: NSCalendarOptions(rawValue: 0))

        if(dateAgo.year > 0) {
            messageAgo = String(dateAgo.year) + NSLocalizedString("Ano", comment: "")
        } else if(dateAgo.month > 0) {
            messageAgo = String(dateAgo.month) + NSLocalizedString("Mes", comment: "")
        } else if(dateAgo.weekOfYear > 0) {
            messageAgo = String(dateAgo.weekOfYear) + NSLocalizedString("Semana", comment: "")
        } else if(dateAgo.day > 0) {
            messageAgo = String(dateAgo.day) + "d"
        } else if(dateAgo.hour > 0) {
            messageAgo = String(dateAgo.hour) + "h"
        } else if(dateAgo.minute > 0) {
            messageAgo = String(dateAgo.minute) + "m"
        } else if(dateAgo.second > 0) {
            messageAgo = String(dateAgo.second) + "s"
        } else {
            messageAgo = "now"
        }

        return messageAgo
    }

    static func showAlert(title : String, message: String, buttonOption1: String?, buttonOption2: String?) -> UIAlertController{
        var alert = UIAlertController()
        
        if buttonOption1!.isEmpty {
            // NADA
        } else {
            alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: buttonOption1!, style: UIAlertActionStyle.Default){ (action) -> Void in
//                decision = true
            })
        }
        
        if buttonOption2!.isEmpty {
            // NADA
        } else {
            alert.addAction(UIAlertAction(title: buttonOption2!, style: UIAlertActionStyle.Default){ (action) -> Void in
//                decision = false
            })
        }
        
        return alert
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    
    static func isValidUsername(testStr:String) -> Bool {
        if(testStr.characters.count < 3) {
            return false
        } else {
            let emailRegEx = "^[a-zA-Z0-9_]{3,16}$"

            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(testStr)
        }
    }

    static func addLogoHeader() -> UIImageView {
        return UIImageView(image: UIImage(named: "logoHeader"))
    }
}
