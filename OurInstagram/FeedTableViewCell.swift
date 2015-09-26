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

    
    let username = "mobileprogram1234"
    var numOfLikes:Int? = 0
    var numOfComments:Int = 0
    var likesString = ""
    var commentsString = ""
    var likeFlag = 0
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var likes: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    
    @IBOutlet var like: UIButton!
    
    @IBAction func like(sender: UIButton) {
        self.likeFlag += 1
        var remain = self.likeFlag % 2
        if remain == 1{
            
//            like.setTitle("Dislike", forState: UIControlState.Normal)
            var likesHead = "\(numOfLikes! + 1) LIKES:\n"
            self.likes.text = likesHead + "\(username)," + self.likesString

        }else{
//            like.setTitle("Like", forState: UIControlState.Normal)
            var likesHead = "\(numOfLikes!) LIKES:\n"
            self.likes.text = likesHead + self.likesString
        }
    }
    
    @IBAction func comment(sender: UIButton) {
        
    }

    
    
    var post: SwiftyJSON.JSON? {
        didSet {
            // after 'post' is assigned by a value
            self.setupPost()
        }
    }
    
    override func prepareForReuse() {
        self.picture.image = nil
//        like.setTitle("Like", forState: UIControlState.Normal)
        self.likesString = ""

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
        
        self.numOfLikes = self.post?["likes"]["count"].stringValue.toInt()
        
        
        var likesHead = "\(self.numOfLikes!) LIKES:\n"
        
        let likeArray = self.post!["likes"]["data"]
        
        let likeArrayLength = likeArray.count
        
        for ele in 0...(likeArrayLength-2){
            
            self.likesString = self.likesString + likeArray[ele]["username"].stringValue + "," + likeArray[likeArrayLength-1]["username"].stringValue
        }
        
        self.likes.text = likesHead + self.likesString
        
    }
    
}
