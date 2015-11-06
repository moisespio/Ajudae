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
    @NSManaged var city: String?
    @NSManaged var image: PFFile?
    var isOrganization: Bool {
        get { return self["active"] as! Bool }
        set { self["active"] = newValue }
    }
    
    func signIn(username: String?, password: String?, callback: (success: Bool, error: NSError?) -> ()) {
        User.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
            if(error == nil) {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error)
            }
        })
    }
    
    func resetPassword(email: String?, callback: (success: Bool, error: NSError?) -> ()) {
        User.requestPasswordResetForEmailInBackground(email!, block: { (success, error) -> Void in
            if(success) {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error)
            }
        })
    }
    
    func register(user: User?, callback: (success: Bool, error: NSError?) -> ()) {
        user?.signUpInBackgroundWithBlock({ (success, error) -> Void in
            if(success) {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error)
            }
        })
    }
    
    func editUser(user: User, callback: (success: Bool, error: NSError?) -> ()) {
        user.saveInBackgroundWithBlock({ (success, error) -> Void in
            if(success) {
                callback(success: true, error: nil)
            } else {
                callback(success: false, error: error)
            }
        })
    }
    
    func verifyUsername(username: String?, callback: (success: Bool, error: NSError?) -> ()) {
        let queryCapitalizedString = User.query()!
        queryCapitalizedString.whereKey("nameuser", equalTo:username!.capitalizedString);
        
        let queryLowerCaseString = User.query()!
        queryLowerCaseString.whereKey("nameuser", equalTo:username!.lowercaseString);
        
        let queryNormalString = User.query()!
        queryNormalString.whereKey("nameuser", equalTo:username!);
        
        let finalQuery = PFQuery.orQueryWithSubqueries([queryCapitalizedString, queryLowerCaseString, queryNormalString])
        
        finalQuery.countObjectsInBackgroundWithBlock { (count, error) -> Void in
            if(count > 0) {
                callback(success: false, error: nil)
            } else {
                callback(success: true, error: error)
            }
        }
    }
    
    
    func verifyEmail(email: String, callback: (success: Bool, error: NSError?) -> ()) {
        let query = User.query()!
        query.whereKey("username", equalTo:email);
        
        query.countObjectsInBackgroundWithBlock { (count, error) -> Void in
            if(count > 0) {
                callback(success: false, error: nil)
            } else {
                callback(success: true, error: error)
            }
        }
    }

}