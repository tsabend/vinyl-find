//
//  ViewController.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/8/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftHTTP
import JSONJoy

//http://192.168.0.6:3000/
let apiString = "http://192.168.0.6:3000"

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hitAPI(sender: AnyObject) {
        blockspring()
    }
    
    @IBAction func camera(sender: AnyObject) {
        let imagePicker = UIImagePickerController() //inst
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.mediaTypes = [kUTTypeImage]
        self.presentViewController(imagePicker, animated: false, completion:{})
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let pictureFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filePath = pictureFolder + "/pictureToSend.jpeg"
        let fileUrl = NSURL.fileURLWithPath(filePath)

        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        let imageData = UIImageJPEGRepresentation(image, 0.0)
        imageData.writeToURL(fileUrl!, atomically: true)
        println("Sending Image:")
        // Upload Image to API
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        //http://192.168.0.6:3000
        request.POST("\(apiString)/album_search",
            parameters:
            ["file": HTTPUpload(fileUrl: fileUrl!)],
            success: {(response: HTTPResponse) in
                println("return from server")
                let album = Album(JSONDecoder(response.responseObject!))
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("VFAlbumPreview") as VFAlbumPreview
                vc.album = album
                self.presentViewController(vc, animated: true, completion: nil)
                
            },failure: {(error: NSError, response: HTTPResponse?) in
                println(error)
        })

        picker.dismissViewControllerAnimated(true, completion: {})
    }

    

    
    func blockspring() {


    }

}

