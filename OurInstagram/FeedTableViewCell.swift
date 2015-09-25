//
//  FeedTableViewCell.swift
//  OurInstagram
//
//  Created by LarryHan on 26/09/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Haneke

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var likes: UILabel!
    
    var post: SwiftyJSON.JSON? {
        didSet {
            // after 'post' is assigned by a value
            self.setupPost()
        }
    }
    
    override func prepareForReuse() {
        self.picture.image = nil
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupPost(){
        self.name.text = self.post?["user"]["username"].stringValue
        
        if let picUrl = self.post?["images"]["low_resolution"]["url"].stringValue{
            
            var url = NSURL(string: picUrl)
            self.picture.hnk_setImageFromURL(url!)
        
        }
        
        self.time.text = self.post?["created_time"].stringValue
        self.location.text = self.post?["location"].stringValue
        
        
        
//
        
        
       
        
        
    }
    
}
