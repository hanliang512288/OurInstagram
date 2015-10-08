//
//  PhotoViewController.swift
//  OurInstagram
//
//  Created by bragi on 4/10/2015.
//  Copyright (c) 2015 LarryHan. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    var cameraOverlay: UIImageView!

    @IBAction func photoLibraryButton(sender: UIBarButtonItem) {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .PhotoLibrary
        self.imagePicker.modalPresentationStyle = .Popover
        presentViewController(self.imagePicker, animated: true, completion: nil)
        self.imagePicker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func photoCameraButton(sender: UIBarButtonItem) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.imagePicker.cameraCaptureMode = .Photo
            self.imagePicker.modalPresentationStyle = .FullScreen
            self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
            
            //Camera screen grid
            //            let frameView = CGRectMake(0, imagePicker.navigationBar.frame.size.height, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - imagePicker.navigationBar.frame.size.height)
            
            //Full screen grid
            let frameView = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height )
            let size:CGSize = frameView.size
            cameraOverlay = UIImageView(frame: frameView)
            cameraOverlay.frame = frameView
            //            cameraOverlay.frame = imagePicker.cameraOverlayView!.frame
            cameraOverlay.image = drawGrid(size)
            self.imagePicker.cameraOverlayView = cameraOverlay
            
            presentViewController(self.imagePicker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.contentMode = .ScaleAspectFit
        self.imageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
        self.imageView.image = chosenImage
    }
    
    //Deal with situation when the device does not have camera
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    //Draw grid on the camera view
    func drawGrid (size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(cameraOverlay.frame.size);
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        let numberOfColumns = 3
        let columnWidth = size.width / CGFloat(numberOfColumns)
        let numberOfRows = 3
        let rowheight = size.height / CGFloat(numberOfRows)
        
        CGContextMoveToPoint(context, columnWidth, 0)
        CGContextAddLineToPoint(context, columnWidth, size.height)
        CGContextStrokePath(context)
        CGContextMoveToPoint(context, columnWidth * 2, 0)
        CGContextAddLineToPoint(context, columnWidth * 2, size.height)
        CGContextStrokePath(context)
        
        CGContextMoveToPoint(context, 0, rowheight)
        CGContextAddLineToPoint(context, size.width, rowheight)
        CGContextStrokePath(context)
        CGContextMoveToPoint(context, 0, rowheight * 2)
        CGContextAddLineToPoint(context, size.width, rowheight * 2)
        CGContextStrokePath(context)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //Take actions when image capture is cancelled.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (identifier == "PhotoEditView") {
            if (imageView.image == nil) {
                let alert = UIAlertView()
                alert.title = "No photo selected!"
                alert.message = "Please select a photo to crop."
                alert.addButtonWithTitle("OK")
                alert.show()
                return false
            }
            else {
                return true
            }
        }
        return true
    }
    
    //Segue setting to pass the image to destinations
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PhotoEditView" {
            let destinationViewController = segue.destinationViewController as! PhotoCropViewController
            destinationViewController.newImage = self.imageView.image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}