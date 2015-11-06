//
//  Category.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class Category: PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Category"
    }
    
    @NSManaged var title: String?
    
    func getCategories(callback: (categories: [Category], error: NSError?) -> ()) {
        let query = PFQuery(className: Story.parseClassName())
        
        query.orderByDescending("createdAt")
        query.limit = 1000
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                callback(categories: objects as! [Category], error: nil)
            } else {
                callback(categories: [], error: error!)
            }
        }
    }
}
