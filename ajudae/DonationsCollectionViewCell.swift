//
//  DonationsCollectionViewCell.swift
//  ajudae
//
//  Created by Moisés Pio on 11/6/15.
//  Copyright © 2015 Moisés Pio. All rights reserved.
//

import UIKit

class DonationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!

    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
}
