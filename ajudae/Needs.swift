//
//  Needs.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class Needs: PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Needs"
    }
    
    @NSManaged var title: String?
    @NSManaged var story: Story?

    func getNeeds(story: String?, callback: (needs: [Needs], error: NSError?) -> ()) {
        let query = PFQuery(className: Story.parseClassName())

        query.orderByDescending("createdAt")
        query.limit = 1000
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                callback(needs: objects as! [Needs], error: nil)
            } else {
                callback(needs: [], error: error!)
            }
        }
    }
    
    func newNeed(need: Needs, callback: (success: Bool, error: NSError?) -> ()) {
        need.saveInBackgroundWithBlock {
            (success, error) -> Void in
            if success {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error!)
            }
        }
    }
}
