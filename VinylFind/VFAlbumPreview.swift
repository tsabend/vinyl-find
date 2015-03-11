//
//  VFAlbumPreview.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/10/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
class VFAlbumPreview : UIViewController {


    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var condition: UISegmentedControl!

    @IBOutlet weak var albumTitle: UILabel!
    var album : Album?
    
    override func viewDidLoad() {
        if let thisAlbum = album as Album! {
            albumTitle.text = thisAlbum.title
            artist.text = thisAlbum.artist
            self.getThumbnail()
            releaseDate.text = thisAlbum.releaseDate
            price.text = "$\(thisAlbum.price!)"
        } else {
            println("no album :(")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "spotifyEmbed" {
            let vc = segue.destinationViewController as VFSpotifyPreview
            vc.songs = self.album?.songPreviews
        }
    }

    func getThumbnail() {
        thumb.alpha = 0
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let url = NSURL(string: self.album!.thumb!)
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
    
    @IBAction func changeCondition(sender: AnyObject) {
        if let condition = sender as? UISegmentedControl {
            switch condition.selectedSegmentIndex {
            case 0:
                self.album?.condition = "Poor"
            case 1:
                self.album?.condition = "Fair"
            case 2:
                self.album?.condition = "Good"
            case 3:
                self.album?.condition = "Excellent"
            default:
                self.album?.condition = "Default?"
            }
            println(self.album?.condition)
        }
    }
    @IBAction func confirm(sender: AnyObject) {
        println("BLAMMO")
        if let album = album as Album! {
            let params : Dictionary<String, AnyObject> = [
                "title": album.title!,
                "artist": album.artist!,
                "thumb": album.thumb!,
                "release_date": album.releaseDate!,
                "price": album.price!,
                "spotify_id": album.spotifyId!,
                "condition": album.condition!
            ]
            var request = HTTPTask()
            request.POST(apiString,
                parameters: params,
                success: {(response: HTTPResponse) in println("Added to DB")},
                failure: {(error: NSError, response: HTTPResponse?) in println("Failed to add to DB")}
            )
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
