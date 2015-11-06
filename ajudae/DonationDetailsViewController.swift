//
//  DonationDetailsViewController.swift
//  ajudae
//
//  Created by Rafael Valer on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class DonationDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var labelItemTitle: UILabel!
    @IBOutlet weak var labelItemDescription: UILabel!
    @IBOutlet weak var imageDonation: UIImageView!
    var donation: Donation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInfo()
        
        self.buttonSend.layer.cornerRadius = 4
        self.buttonSend.clipsToBounds = true
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.width/2
        self.imageProfile.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInfo(){
        guard let _donation = self.donation else {
            return
        }
        if let photo = _donation.image,
            _url = photo.url {
                let url = NSURL(string: _url)
                self.imageDonation.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "placeholder"))
        }
        
        self.navigationItem.title = _donation.title
        self.labelItemTitle.text = _donation.title
        self.labelItemDescription.text = _donation.about
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueDetailsToApplyDonation" {
            let pVC = segue.destinationViewController as! ApplyViewController
            pVC.donation = sender as? Donation
        }
    }
    
    @IBAction func buttonWantDonationClicked(sender: AnyObject) {
        
        guard let _donation = self.donation else {
            return
        }
        
        self.performSegueWithIdentifier("segueDetailsToApplyDonation", sender: _donation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
