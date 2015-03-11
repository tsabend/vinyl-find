//
//  VFSpotifyPreview.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/9/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VFSpotifyPreview : AVPlayerViewController {

    @IBOutlet weak var playButton: UIButton!
    var songs : [Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError? = nil
        if songs != nil {
            if let firstSong = songs?.first as Song! {
                let fileURL = NSURL(string: firstSong.previewUrl!)
                player = AVPlayer(URL: fileURL)
            }
        } else {
            let spotify = "https://p.scdn.co/mp3-preview/4ea9c360581959eefbbb9ae61a2e8f717325e80b"
            let fileURL = NSURL(string: spotify)
            player = AVPlayer(URL: fileURL)
        }
    }
    
    @IBAction func pressPlay(sender: AnyObject) {
        player.play()
    }
}
