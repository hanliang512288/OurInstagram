//
//  DiscoverTableViewController.swift
//  OurInstagram
//
//  Created by 647 on 10/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DiscoverTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let token = "2203590801.aabf771.701252ebb0f4425cbc8231c41a0e5732"
    
    var recommendJson:JSON = nil
    var recommendError:AnyObject? = nil
    var recommendSorted:Array<JSON> = []
    
    var searchJson:JSON = nil
    var searchError:AnyObject? = nil
    var resultSearchController = UISearchController()
    
    let cellIdentifier:String = "dicoverCell"

    override func viewDidLoad() {
        self.tableView.rowHeight = 60
        self.tableView.allowsSelection = false
        
        tableView.registerNib(UINib(nibName: "DiscoverTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        loadRecommend()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents:UIControlEvents.ValueChanged)
        
        self.navigationItem.title = "OurInstagram"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl){
        loadRecommend()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRecommend(){
        let recommendUrl = "https://mobileprogram.herokuapp.com/recommendation.json"
        Alamofire.request(.GET,recommendUrl).responseJSON{
            (_,_,data,error) in
            self.recommendJson = JSON(data!)
            self.recommendError = error
            
            self.recommendSorted = self.recommendJson["data"].arrayValue
            self.recommendSorted.sort({$0["rank"] < $1["rank"]})
            
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
        if self.resultSearchController.active {
            if self.searchJson == nil {
                return 0
            }
            else {
                return self.searchJson["data"].count
            }
        }
        else {
            return self.recommendSorted.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DiscoverTableViewCell
        
        if self.resultSearchController.active {
            if self.searchJson != nil {
                cell.post = self.searchJson["data"][indexPath.row]
            }
        }
        else {
            cell.post = self.recommendSorted[indexPath.row]
        }
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchUrl = "https://api.instagram.com/v1/users/search?q=\(searchText)&access_token=\(token)"
        Alamofire.request(.GET,searchUrl).responseJSON{
            (_,_,data,error) in
            self.searchJson = JSON(data!)
            self.searchError = error
            self.tableView.reloadData()
        }
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
