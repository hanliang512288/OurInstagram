//
//  ProfileCollectionViewCell.swift
//  OurInstagram
//
//  Created by LarryHan on 11/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var imageEachCell: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    override func prepareForReuse() {
        self.imageEachCell.image = nil
    }

}
