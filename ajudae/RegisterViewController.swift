//
//  RegisterViewController.swift
//  Mimic
//
//  Created by Matheus Frozzi Alberton on 26/10/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func register(sender: AnyObject) {
        let user = User()

        let username = self.email.text
        let email = self.email.text
        let password = self.password.text
        
        if(username!.characters.count < 3) {
            self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("usernameChar", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
//            self.nextButton.enabled = true
            return
        }

        if(!Util.isValidUsername(username!)) {
            self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("validUsername", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
//            self.nextButton.enabled = true
            return
        }

        if(!Util.isValidEmail(email!)) {
            self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("validEmail", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
        }

        if(password!.characters.count < 4) {
            self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("validPassword", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
        }

        user.verifyUsername(username, callback: { (success, error) -> () in
            if success {
                user.username = username
                user.email = email
                user.password = password

                user.register(user) { (success, error) -> () in
                    if success {
                        PushNotifications.associateDeviceWithCurrentUser()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("tryAgain", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
                    }
                }
            } else {
                self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("userExists", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
            }
        })
    }
}
extension RegisterViewController : UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.email) {
            let caracter : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
            let cs : NSCharacterSet = NSCharacterSet(charactersInString: caracter).invertedSet
            let array:[String] = string.componentsSeparatedByCharactersInSet(cs)
            
            let filtered = array.reduce("", combine: { (oldS:String, nString:String) -> String in
                return oldS+nString
            })

            return string == filtered.lowercaseString
        }
        if (textField == self.email) {
            let caracter : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@"
            let cs : NSCharacterSet = NSCharacterSet(charactersInString: caracter).invertedSet
            let array:[String] = string.componentsSeparatedByCharactersInSet(cs)
            
            let filtered = array.reduce("", combine: { (oldS:String, nString:String) -> String in
                return oldS+nString
            })
            return string == filtered
        }
        
        return true
    }
}