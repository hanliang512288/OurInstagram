//
//  ProfileViewController.swift
//  OurInstagram
//
//  Created by Zita Liu on 11/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numPost: UILabel!
    @IBOutlet weak var textPost: UILabel!
    @IBOutlet weak var numFlwer: UILabel!
    @IBOutlet weak var textFlwer: UILabel!
    @IBOutlet weak var numFlwing: UILabel!
    @IBOutlet weak var textFlwing: UILabel!
    
  
    @IBOutlet weak var profileCollectionView: UICollectionView!

    
    let token = "2203590801.aabf771.701252ebb0f4425cbc8231c41a0e5732"
    var infoJson:JSON = nil
    var photoJson:JSON = nil
    var jasonError:AnyObject? = nil
    var cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var flow:UICollectionViewFlowLayout = self.profileCollectionView.collectionViewLayout as!
            UICollectionViewFlowLayout
        flow.itemSize = CGSizeMake(80, 80)
    
        var nipName=UINib(nibName: "ProfileCollectionViewCell", bundle:nil)
        self.profileCollectionView.registerNib(nipName, forCellWithReuseIdentifier: cellIdentifier)
        
        
        loadProfile()
        loadCollectionView()
//        self.profileCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProfile() {
        let infoUrl = "https://api.instagram.com/v1/users/self/?access_token=\(token)"
        Alamofire.request(.GET,infoUrl).responseJSON{
            (_,_,data,error) in
            self.infoJson = JSON(data!)
            self.jasonError = error
            self.infoJson = self.infoJson["data"]
            
            //Display user's full name
            self.name.text = self.infoJson["full_name"].stringValue
            
            //Display user's profile picture
            let picUrl = self.infoJson["profile_picture"].stringValue
            var url = NSURL(string: picUrl)
            self.profilePic.hnk_setImageFromURL(url!)
            self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height/2
            self.profilePic.layer.masksToBounds = true
            self.profilePic.layer.borderWidth = 0
            
            //Display stats on posts, followers, following
            self.numPost.text = self.infoJson["counts"]["media"].stringValue
            
            self.numFlwer.text = self.infoJson["counts"]["followed_by"].stringValue
            
            self.numFlwing.text = self.infoJson["counts"]["follows"].stringValue
//
        }
    }
    
    func loadCollectionView(){
        let infoUrl = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(token)"
        Alamofire.request(.GET,infoUrl).responseJSON{
            (_,_,data,error) in
            self.photoJson = JSON(data!)
            self.photoJson = self.photoJson["data"]
            
            self.profileCollectionView.reloadData()
            self.jasonError = error
//            print(self.photoJson)
        }
    }
    
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoJson.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: ProfileCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProfileCollectionViewCell
        
        let photoUrl = self.photoJson[indexPath.row]["images"]["thumbnail"]["url"].stringValue
        
        print(photoUrl)
        var url = NSURL(string: photoUrl)
        
        cell.imageEachCell.hnk_setImageFromURL(url!)
        
        return cell
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
