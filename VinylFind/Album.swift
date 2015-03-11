//
//  Album.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/9/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy


struct Catalog : JSONJoy {
    var albums : [Album]?
    
    init() {
    
    }
    
    init(_ decoder: JSONDecoder) {
        if let albumDecoders = decoder["albums"].array {
            albums = [Album]()
            
            for albumDecoder in albumDecoders {
                albums!.append(Album(albumDecoder))
            }
        }
    }
    
    static func getAlbums(completion: Catalog -> Void) {
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        request.GET(apiString,
            parameters: nil,
            success: {(response: HTTPResponse) in
                println("succesful return from server")
                let catalog = Catalog(JSONDecoder(response.responseObject!))
                dispatch_async(dispatch_get_main_queue()) {
                    completion(catalog)
                }
            },
            failure: {(error: NSError, response: HTTPResponse?) in println("Failed to get albums")
            })
    }

}

struct Album : JSONJoy {

    var title : String?
    var artist : String?
    var releaseDate : String?
    var thumb : String?
    var spotifyId : String?
    var songPreviews : [Song]?
    var price : Int?
    var condition : String?

    init() {
        
    }
    
    init(_ decoder: JSONDecoder) {
        title = decoder["title"].string!
        artist = decoder["artist"].string!
        releaseDate = decoder["release_date"].string!
        thumb = decoder["thumb"].string!
        spotifyId = decoder["spotify_id"].string!
        price = decoder["price"].integer!
        if let previews = decoder["song_previews"].array {
            songPreviews = [Song]()
            for songDecoder in previews {
                songPreviews!.append(Song(songDecoder))
            }
        }
        condition = "Fair"
    }
    
    
}

struct Song : JSONJoy {
    
    var name : String?
    var previewUrl : String?
    var durationMS : Int?
    
    init() {
        
    }
    init(_ decoder: JSONDecoder) {
        name = decoder["name"].string!
        previewUrl = decoder["preview_url"].string!
        durationMS = decoder["duration_ms"].integer!
    }
}