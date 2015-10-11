//
//  ActivityTableViewCell.swift
//  OurInstagram
//
//  Created by 647 on 10/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Haneke

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var option: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var mediaPic: UIImageView!
    @IBOutlet weak var followUsername: UILabel!
    
    var post: SwiftyJSON.JSON? {
        didSet {
            self.setupPost()
        }
    }
    
    override func prepareForReuse() {
        self.profilePic.image = nil
        self.mediaPic.image = nil
        self.followUsername.text = nil
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
        var timeStamp = self.post?["time"].intValue
        self.time.text = timeFormat(timeStamp!)
        if let profilePicUrl = self.post?["profile_picture"].stringValue{
            var url = NSURL(string: profilePicUrl)
            self.profilePic.hnk_setImageFromURL(url!)
        }
        self.username.text = self.post?["username"].stringValue
        
        if self.post?["followUsername"].stringValue == "" {
            if self.post?["image"].stringValue == "" {
                self.option.text = "I start follow"
            }
            else {
                self.option.text = "I like"
                if let mediaPicUrl = self.post?["image"].stringValue{
                    var url = NSURL(string: mediaPicUrl)
                    self.mediaPic.hnk_setImageFromURL(url!)
                }
            }
        }
        else{
            if self.post?["image"].stringValue == "" {
                self.option.text = "start follow"
                self.followUsername.text = self.post?["followUsername"].stringValue
            }
            else {
                self.option.text = "post"
                if let mediaPicUrl = self.post?["image"].stringValue{
                    var url = NSURL(string: mediaPicUrl)
                    self.mediaPic.hnk_setImageFromURL(url!)
                }
            }
        }
    }
    
    func timeFormat(timestamp:Int) -> String{
        var date = NSDate(timeIntervalSince1970: Double(timestamp))
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .MediumStyle
        let timeString = formatter.stringFromDate(date)
        return timeString
        
    }
    
}
