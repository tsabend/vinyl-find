//
//  VFRecordCollectionView.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/10/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation
import UIKit

class VFRecordCollectionView : UITableViewController, UITableViewDataSource, UITableViewDelegate {


    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Catalog.getAlbums() {
        catalog in
            println("in completion \(catalog.albums!)")
            self.albums = catalog.albums!
            self.tableView.reloadData()
        }
    }

    // TABLEVIEW DELEGATE/DATASOURCE
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VFAlbumCell", forIndexPath: indexPath) as VFAlbumCell
        let album = albums[indexPath.row]
        cell.setupAlbumCell(album)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let album = albums[indexPath.row]
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("VFAlbumPreview") as VFAlbumPreview
        vc.album = album
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}