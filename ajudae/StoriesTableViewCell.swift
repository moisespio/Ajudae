//
//  StoriesTableViewCell.swift
//  ajudae
//
//  Created by Moisés Pio on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var viewContainer: UIView!

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelNumSupports: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {
        self.viewContainer.layer.cornerRadius = 4
        self.viewContainer.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
