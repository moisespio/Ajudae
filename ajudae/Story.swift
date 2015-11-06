//
//  Story.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit
import Parse

class Story: PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Story"
    }
    
    @NSManaged var user: User?
    @NSManaged var title: String?
    @NSManaged var story: String?
    @NSManaged var image: PFFile?
    @NSManaged var countSupports: NSNumber?
    @NSManaged var endDate: NSDate?
    
    var needs: PFRelation {
        return self.relationForKey("needs")
    }

    func getStories(callback: (stories: [Story], error: NSError?) -> ()) {
        let query = PFQuery(className: Story.parseClassName())

        query.orderByDescending("createdAt")
        query.limit = 1000

        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                callback(stories: objects as! [Story], error: nil)
            } else {
                callback(stories: [], error: error!)
            }
        }
    }

    func newStory(story: Story, callback: (success: Bool, error: NSError?) -> ()) {
        story.saveInBackgroundWithBlock {
            (success, error) -> Void in
            if success {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error!)
            }
        }
    }
}
