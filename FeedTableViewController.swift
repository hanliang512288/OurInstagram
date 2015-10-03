//
//  FeedTableViewController.swift
//  OurInstagram
//
//  Created by LarryHan on 24/09/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedTableViewController: UITableViewController {

      
    
    let token = "2203590801.aabf771.701252ebb0f4425cbc8231c41a0e5732"
    var feedJson:JSON = nil
    var feedError:AnyObject? = nil
    let cellIdentifier:String = "feedCell"
    
    
    override func viewDidLoad() {
        self.tableView.rowHeight = 589
        self.tableView.allowsSelection = false
        
        tableView.registerNib(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        super.viewDidLoad()
        loadFeed()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)

        
//        var rightDateBarButtonItem:UIBarButtonItem = UIBarButtonItem(title:"Date",style:UIBarButtonItemStyle.Plain,target:self,action:"sortByDate:")
//         var leftDateBarButtonItem:UIBarButtonItem = UIBarButtonItem(title:"Location",style:UIBarButtonItemStyle.Plain,target:self,action:"sortByLocation:")
//        
//        self.navigationItem.setRightBarButtonItem(rightDateBarButtonItem, animated: true)
//    
//        self.navigationItem.setLeftBarButtonItem(leftDateBarButtonItem, animated: true)
        
        self.navigationItem.title = "OurInstagram"
        
    }
    
    
//    func sortByDate(sender:UIButton){
//    }
//    
//    func sortByLocation(sender:UIButton){
//    }
//    
    
    func handleRefresh(refreshControl: UIRefreshControl){
        loadFeed()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
   
    }

    func loadFeed(){
        let feedUrl = "https://api.instagram.com/v1/users/self/feed?access_token=\(token)"
        Alamofire.request(.GET,feedUrl).responseJSON{
            (_,_,data,error) in
                self.feedJson = JSON(data!)
                self.feedError = error
                print(self.feedJson["data"][0])
            
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
        }
    }
    
//    func loadFeed(callBack:(JSON,NSError)->())->(){
//        
//       let feedUrl = "https://api.instagram.com/v1/users/self/feed?access_token=\(token)"
//            
//            Alamofire.request(.GET,feedUrl).responseJSON{
//                (_,_,data,error) in
//                self.feedJson = JSON(data!)
//                callBack(self.feedJson,error!)
//            }
//    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.feedJson["data"].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FeedTableViewCell
        
        cell.post = self.feedJson["data"][indexPath.row]
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
