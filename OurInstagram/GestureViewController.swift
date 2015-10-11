//
//  GestureViewController.swift
//  OurInstagram
//
//  Created by bragi on 7/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class GestureViewController:UIViewController  {
    
    let serviceType = "Local-Chat"
    
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID: MCPeerID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addGestureRecognizer(upSwipe)
        self.view.addGestureRecognizer(downSwipe)
        
    }
    
    func handleSwipe(sender:UISwipeGestureRecognizer) {
            print("Swipe Photos.")
    }
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}