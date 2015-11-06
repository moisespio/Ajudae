//
//  ApplyViewController.swift
//  ajudae
//
//  Created by Moisés Pio on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class ApplyViewController: UIViewController {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var textViewMessage: UITextView!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var labelItemTitle: UILabel!
    @IBOutlet weak var labelItemDescription: UILabel!

    var donation: Donation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonSend.layer.cornerRadius = 4
        self.buttonSend.clipsToBounds = true
        self.textViewMessage.layer.cornerRadius = 4
        self.textViewMessage.clipsToBounds = true
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.width/2
        self.imageProfile.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        self.loadInfo()
    }
    
    func dismissKeyboard() {
        self.textViewMessage.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadInfo(){
        guard let _donation = self.donation else {
            return
        }
        
        self.navigationItem.title = _donation.title
        self.labelItemTitle.text = _donation.title
        self.labelItemDescription.text = _donation.about
    }

    @IBAction func applyForDonation(sender: AnyObject) {
        
        guard let _donation = self.donation else {
            return
        }
        
        let newApplyDonation = ApplyDonation()
        newApplyDonation.donation = _donation
        newApplyDonation.reason = self.textViewMessage.text
        if let user = User.currentUser() {
            newApplyDonation.user = user
        }
        
        newApplyDonation.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                self.performSegueWithIdentifier("unwindSegueFromApplyToDonations", sender: self)
            }
        }
    }
}
