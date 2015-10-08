//
//  GestureViewController.swift
//  OurInstagram
//
//  Created by bragi on 7/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import Foundation
import UIKit

class GestureViewController:UIViewController {
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
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    func handleSwipe(sender:UISwipeGestureRecognizer) {
            print("Swipe Photos.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}