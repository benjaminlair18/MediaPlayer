//
//  AsyncImageGetter.swift
//  Users
//
//  Created by harrison on 30/8/15.
//  Copyright (c) 2015 harrison. All rights reserved.
//

import Foundation

class AsyncImageGetter{
    init() {}
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL, callback: ((data: NSData?) -> Void)){
        println("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                println("Finished downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
                
                callback(data: data)
            }
        }
    }
    
}