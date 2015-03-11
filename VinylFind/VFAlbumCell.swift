//
//  VFAlbumCell.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/10/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation
import UIKit

class VFAlbumCell : UITableViewCell {

    @IBOutlet weak var albumTitle: UILabel!
    
    @IBOutlet weak var artist: UILabel!
    
    @IBOutlet weak var thumb: UIImageView!
    
    override func awakeFromNib() {

    }
    
    func setupAlbumCell(album : Album) {
        artist.text = album.artist
        albumTitle.text = album.title
        getThumbnail(album)
    }
    
    func getThumbnail(album: Album) {
        thumb.alpha = 0
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let url = NSURL(string: album.thumb!)
            let data = NSData(contentsOfURL: url!)
            if ( data == nil ) { return }
            dispatch_async(dispatch_get_main_queue()) {
                // Assuming that the data I get back from that URL is in fact an image
                let image = UIImage(data: data!)
                self.thumb.image = image
                UIView.animateWithDuration(0.35, animations: {
                    Void in
                    self.thumb.alpha = 1
                })
            }
        }
    }

}