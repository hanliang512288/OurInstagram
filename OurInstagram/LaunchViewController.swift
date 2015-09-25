//
//  LaunchViewController.swift
//  OurInstagram
//
//  Created by LarryHan on 24/09/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LaunchViewController: UIViewController {

    let token = "2203590801.aabf771.701252ebb0f4425cbc8231c41a0e5732"
    var userJson:JSON = nil
    var a = ""
    
    @IBOutlet weak var userPic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserJson()

    }
    
    func loadUserJson(){
        let userReqUrl = "https://api.instagram.com/v1/users/self/?access_token=\(token)"
        Alamofire.request(.GET,userReqUrl).responseJSON{
            (_,_,json,error) -> Void in
            if json != nil{
                var jsonObj = JSON(json!)
                
                    let data = jsonObj["data"]
                    let name = data["username"].stringValue
                    let pictureAdd = data["profile_picture"].stringValue
                    
                    self.userJson = jsonObj
                    
                    self.userName.text = name
                    
                    if let picUrl = NSURL(string: pictureAdd){
                        if let data = NSData(contentsOfURL:picUrl){
                            self.userPic.contentMode=UIViewContentMode.ScaleAspectFill
                            self.userPic.image=UIImage(data:data)
                }
                
            }

           }
        }
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
