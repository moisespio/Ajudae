//
//  PushNotifications.swift
//  flockr
//
//  Created by Matheus Frozzi Alberton on 21/08/15.
//  Copyright (c) 2015 flockr. All rights reserved.
//

import UIKit
import Parse

class PushNotifications: NSObject {
    static func associateDeviceWithCurrentUser() {
        let installation = PFInstallation.currentInstallation()
        
        if((installation["user"] == nil) && User.currentUser() != nil) {
            installation["user"] = User.currentUser()
            installation.saveInBackground()
        }
    }

    static func sendPush(lockKey: String, fromProfile: String, toProfile: String, pushType: String, objectId:String, userId: String) {
        let pushQuery = PFInstallation.query()!
        pushQuery.whereKey("user", equalTo: User(withoutDataWithObjectId: userId))

        let values = [fromProfile, toProfile]

        let data = [
            "alert" : [
                "loc-key" : lockKey,
                "loc-args" : values
            ],
            "badge" : "Increment",
            "pushType" : pushType,
            "pushTypeId" : objectId
        ]

        let push = PFPush()
        push.setQuery(pushQuery)
        push.setData(data as [NSObject : AnyObject])
        push.sendPushInBackground()
    }
}