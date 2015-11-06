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
    @NSManaged var about: String?
    
    
    func getDonations(byCategory: String?, callback: (donations: [Donation], error: NSError?) -> ()) {
        let query = PFQuery(className: Donation.parseClassName())

        if let category = byCategory {
            query.whereKey("category", equalTo: Category(withoutDataWithObjectId: category))
        }

        query.orderByDescending("createdAt")
        query.limit = 1000
        
        query.includeKey("user")

        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                callback(donations: objects as! [Donation], error: nil)
            } else {
                callback(donations: [], error: error!)
            }
        }
    }

    func newDonation(donation: Donation, callback: (success: Bool, error: NSError?) -> ()) {
        donation.saveInBackgroundWithBlock {
            (success, error) -> Void in
            if success {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error!)
            }
        }
    }

}
