//
//  InRangeTableViewController.swift
//  OurInstagram
//
//  Created by LarryHan on 9/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import MBProgressHUD

class InRangeTableViewController: UITableViewController,MCSessionDelegate {

    
    
    
    //Variables for MPC
    let serviceType = "Local-Chat"
    var assistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID: MCPeerID!
    let cellIdentifier:String = "rangeCell"
    var storeArray:[[NSString:NSString]] = []
    var sortedArray:[[NSString:NSString]] = []
    let username = "mobileprogram1234"
    
    
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photos in Range"
        
        self.tableView.rowHeight = 100
        self.tableView.allowsSelection = false
        
        tableView.registerNib(UINib(nibName: "InRangeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.peerID = MCPeerID(displayName: username)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // the advertiser
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session)
        // start advertising
        self.assistant.start()
        

    }
    
    func handleRefresh(refreshControl: UIRefreshControl){
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.storeArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InRangeTableViewCell
        
        cell.post = self.sortedArray[indexPath.row]
        
        return cell
    }
    
    var Timestamp: String {
        return "\(NSDate().timeIntervalSince1970)"
    }
    
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        // when receiving a data
        dispatch_async(dispatch_get_main_queue(), {
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.Indeterminate
            loadingNotification.labelText = "Receiving photo from \(peerID.displayName)"
            
            var msg = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var photoDic:[NSString:NSString] = ["name":"\(peerID.displayName)","time":self.Timestamp,"data":msg]
            self.storeArray.append(photoDic)
            self.sortedArray = reverse(self.storeArray)
            print("finished")
            loadingNotification.hide(true, afterDelay:1)
            

        })
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
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
