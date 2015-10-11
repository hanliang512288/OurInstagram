//
//  ActivityTableViewController.swift
//  OurInstagram
//
//  Created by 647 on 10/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ActivityTableViewController: UITableViewController {
    
    let token = "2203590801.aabf771.701252ebb0f4425cbc8231c41a0e5732"
    
    var followingJson:JSON = nil
    var followingError:AnyObject? = nil
    var followingSorted:Array<JSON> = []
    
    var youJson:JSON = nil
    var youError:AnyObject? = nil
    var youSorted:Array<JSON> = []
    
    let cellIdentifier:String = "activityCell"
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func changeTab(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loadFollowing()
        case 1:
            loadYou()
        default:
            break;
        }
    }

    override func viewDidLoad() {
        
        self.tableView.rowHeight = 100
        self.tableView.allowsSelection = false
        
        tableView.registerNib(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        super.viewDidLoad()
        
        loadFollowing()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.navigationItem.title = "OurInstagram"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl){
        if self.segmentedControl.selectedSegmentIndex == 0 {
            loadFollowing()
        }
        else{
            loadYou()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFollowing(){
        let followingUrl = "https://mobileprogram.herokuapp.com/following.json"
        Alamofire.request(.GET,followingUrl).responseJSON{
            (_,_,data,error) in
            self.followingJson = JSON(data!)
            self.followingError = error
            
            self.followingSorted = self.followingJson["data"].arrayValue
            self.followingSorted.sort({$0["time"] > $1["time"]})
            
            self.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }
    }
    
    func loadYou(){
        let youUrl = "https://mobileprogram.herokuapp.com/you.json"
        Alamofire.request(.GET,youUrl).responseJSON{
            (_,_,data,error) in
            self.youJson = JSON(data!)
            self.youError = error
            
            self.youSorted = self.youJson["data"].arrayValue
            self.youSorted.sort({$0["time"] > $1["time"]})
            
            self.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if self.segmentedControl.selectedSegmentIndex == 0 {
            return self.followingSorted.count
        }
        else{
            return self.youSorted.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ActivityTableViewCell
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            cell.post = self.followingSorted[indexPath.row]
        }
        else{
            cell.post = self.youSorted[indexPath.row]
        }
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
