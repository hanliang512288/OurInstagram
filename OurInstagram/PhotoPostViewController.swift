//
//  PhotoPostViewController.swift
//  OurInstagram
//
//  Created by bragi on 4/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//
//  Provide users with functions to post images through calling the "Instagram" API.
//  Provide button to go back to previous view.

import Foundation
import UIKit
import AssetsLibrary

class PhotoPostViewController:UIViewController,UIDocumentInteractionControllerDelegate {
    
    var newImage = UIImage(named: "photo.igo")
    
    //Create controller to handle document interaction
    var documentController:UIDocumentInteractionController!

    //Create image view to dispaly image
    @IBOutlet weak var imageView: UIImageView!

    //Go back to previous view
    @IBAction func backButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Call the "Instagram" application to post image
    @IBAction func photoPostButton(sender: UIButton) {
        print("button photo")
        let image = self.newImage
        let filename = "photo.igo"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, false)[0] as! NSString
        let destinationPath = documentsPath.stringByAppendingString("/" + filename)
        let f = destinationPath.stringByExpandingTildeInPath
        UIImagePNGRepresentation(image).writeToFile(f, atomically:true)
        let fileURL = NSURL(fileURLWithPath: f)! as NSURL
        
        self.documentController = UIDocumentInteractionController(URL: fileURL)
        self.documentController.delegate = self
        documentController.UTI = "com.instagram.exclusivegram"
        documentController.presentOpenInMenuFromRect(CGRectZero, inView: self.view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.newImage
        
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
            swipePhoto()
    }
    
    func swipePhoto() {
        let image = self.newImage
        let filename = "photo.igo"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, false)[0] as! NSString
        let destinationPath = documentsPath.stringByAppendingString("/" + filename)
        let f = destinationPath.stringByExpandingTildeInPath
        UIImagePNGRepresentation(image).writeToFile(f, atomically:true)
        let fileURL = NSURL(fileURLWithPath: f)! as NSURL
        
        self.documentController = UIDocumentInteractionController(URL: fileURL)
        self.documentController.delegate = self
        documentController.UTI = "com.instagram.exclusivegram"
        documentController.presentOpenInMenuFromRect(CGRectZero, inView: self.view, animated: false)
        print("Swipe photo")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
