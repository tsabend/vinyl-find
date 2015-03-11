//
//  VFCamera.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/8/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class VFCamera : UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        sourceType = UIImagePickerControllerSourceType.Camera
        mediaTypes = [kUTTypeImage]
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Foo")
    }
    


}