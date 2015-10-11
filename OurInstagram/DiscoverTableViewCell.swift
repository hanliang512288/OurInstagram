//
//  DiscoverTableViewCell.swift
//  OurInstagram
//
//  Created by 647 on 10/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Haneke

class DiscoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    var post: SwiftyJSON.JSON? {
        didSet {
            // after 'post' is assigned by a value
            self.setupPost()
        }
    }
    
    override func prepareForReuse() {
        self.profilePic.image = nil
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupPost(){
        if let profilePicUrl = self.post?["profile_picture"].stringValue{
            var url = NSURL(string: profilePicUrl)
            self.profilePic.hnk_setImageFromURL(url!)
        }
        self.username.text = self.post?["username"].stringValue
    }
    
}
