//
//  Donation.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class Donation: PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Donation"
    }
    
    @NSManaged var user: User?
    @NSManaged var title: String?
    @NSManaged var image: PFFile?
    @NSManaged var countApply: NSNumber?
    @NSManaged var category: Category?
    
}
