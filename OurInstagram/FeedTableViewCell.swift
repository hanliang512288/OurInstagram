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
    var numOfComments:Int? = 0
    var likesString = ""
    var commentsString = ""
    var likeFlag = 0
    var myComment = ""
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var likes: UILabel!
    
//    @IBOutlet weak var comments: UILabel!
    
    @IBOutlet weak var commentsDisplay: UILabel!
    
    @IBOutlet weak var comment: UITextField!

    @IBAction func send(sender: UIButton) {
        
        self.myComment = self.comment.text
        self.comment.text = ""
        print(self.myComment)
        self.comment.resignFirstResponder()
        self.numOfComments = self.numOfComments! + 1
        var head = "\(numOfComments!) COMMENTS:\n"
        self.commentsString = "\(username):\(self.myComment)\n"+self.commentsString
        self.commentsDisplay.text = head + self.commentsString
    }
    
    @IBOutlet weak var portrait: UIImageView!
    
   
    
  

   
    @IBAction func like(sender: UIButton) {
        self.likeFlag += 1
        var remain = self.likeFlag % 2
        if remain == 1{
            sender.setTitle("Dislike", forState: UIControlState.Normal)
//            self.like.setTitle("Dislike", forState: UIControlState.Normal)
            var likesHead = "\(numOfLikes! + 1) LIKES:\n"
            self.likes.text = likesHead + "\(username)," + self.likesString

        }else{
            sender.setTitle("Like", forState: UIControlState.Normal)
            var likesHead = "\(numOfLikes!) LIKES:\n"
            self.likes.text = likesHead + self.likesString
        }
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
        self.commentsString = ""
        self.portrait.image = nil
//        self.comments.delegate = self

    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        self.comments.placeholder = "Comments"
//        self.comments.returnKeyType = UIReturnKeyType.Done
//        
//    }
//    
//    func textFieldShouldReturn(textField:UITextField)->Bool{
//        textField.resignFirstResponder()
//        print("abvc")
//        return true;
//    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func timeFormat(timestamp:Int) -> String{
        var date = NSDate(timeIntervalSince1970: Double(timestamp))
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .MediumStyle
        let timeString = formatter.stringFromDate(date)
        return timeString
        
    }
    
    func displayComments(commentsJson:SwiftyJSON.JSON)->String{
        self.numOfComments! = commentsJson["count"].intValue
        var numOfComInJson = commentsJson["data"].count
        var head = "\(self.numOfComments!) COMMENTS: \n"
        var commentsData = commentsJson["data"]
        if numOfComInJson>0{
            var numOfDisplay = min(numOfComInJson,8)
            for i in 0...(numOfDisplay-1){
                var name = commentsData[i]["from"]["username"].string!
                var text = commentsData[i]["text"].string!
                
                self.commentsString = self.commentsString+name+":"+text+"\n"
            }
        }
        return head+self.commentsString
    }
    
    func setupPost(){
        
        //Display name
        self.name.text = self.post?["user"]["username"].stringValue
        
        //Display profile picture of feed user
        if let picUrl = self.post?["images"]["low_resolution"]["url"].stringValue{
            var url = NSURL(string: picUrl)
            self.picture.hnk_setImageFromURL(url!)
        }
        
        //Display post feed picture
        if let proUrl = self.post?["user"]["profile_picture"].stringValue{
            var url = NSURL(string:proUrl)
            self.portrait.hnk_setImageFromURL(url!)
        }
        
        //Display post time
        let timeStamp = self.post?["created_time"].intValue
        self.time.text = timeFormat(timeStamp!)
        
        //Display location
        self.location.text = self.post?["location"].stringValue
        
        //Display number of likes and likes
        self.numOfLikes = self.post?["likes"]["count"].stringValue.toInt()
        var likesHead = "\(self.numOfLikes!) LIKES:\n"
        let likeArray = self.post!["likes"]["data"]
        let likeArrayLength = likeArray.count
        
        //Here got some question need to be modified
        if likeArrayLength>1{
            for ele in 0...(likeArrayLength-2){
                self.likesString = self.likesString + likeArray[ele]["username"].stringValue + ","        }
             self.likesString = self.likesString  + likeArray[likeArrayLength-1]["username"].stringValue
            
        }else if likeArrayLength>0{
            self.likesString = self.likesString  + likeArray[likeArrayLength-1]["username"].stringValue
        }
        
        self.likes.text = likesHead + self.likesString
        
        //Display comments
        var commentsJson = self.post?["comments"]
        self.commentsDisplay.text = displayComments(commentsJson!)
        
        
    }
    
}
