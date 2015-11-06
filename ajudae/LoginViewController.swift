//
//  LoginViewController.swift
//  Mimic
//
//  Created by Matheus Frozzi Alberton on 23/10/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        let username = self.username.text
        let password = self.password.text
        
        if(username != "" && password != "") {
            let user = User()

            user.signIn(username, password: password, callback: { (success, error) -> () in
                if(success == true) {
                    PushNotifications.associateDeviceWithCurrentUser()
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("Usuario ou senha incorretos", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
                }
            })
        } else {
            self.presentViewController(Util.showAlert("Ops!", message: NSLocalizedString("Preencha todos campos", comment: ""), buttonOption1: "OK!", buttonOption2: ""), animated: true, completion: nil)
        }
    }
}
