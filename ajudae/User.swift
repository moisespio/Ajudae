//
//  User.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var address: String?
    var isOrganization: Bool {
        get { return self["active"] as! Bool }
        set { self["active"] = newValue }
    }
}