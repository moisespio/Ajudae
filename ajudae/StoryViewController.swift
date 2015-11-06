//
//  StoryViewController.swift
//  ajudae
//
//  Created by Moisés Pio on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelStoryTitle: UILabel!
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var labelStoryDescription: UILabel!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var labelNeeds: UILabel!
    @IBOutlet weak var buttonSupport: UIButton!
    @IBOutlet weak var viewWhite: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewWhite.layer.cornerRadius = 4
        self.viewWhite.clipsToBounds = true
        self.imageStory.layer.cornerRadius = 4
        self.imageStory.clipsToBounds = true
        self.buttonSupport.layer.cornerRadius = 4
        self.buttonSupport.clipsToBounds = true
        self.viewMap.layer.cornerRadius = 4
        self.viewMap.clipsToBounds = true
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.width/2
        self.imageProfile.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
