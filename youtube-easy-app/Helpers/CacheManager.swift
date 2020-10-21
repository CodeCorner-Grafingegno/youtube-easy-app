//
//  CacheManager.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 19/10/2020.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url:String, _ data:Data) {
        
        cache[url] = data
    }
    
    static func getVideoCache(_ url:String) -> Data? {
        
        return cache[url]
        
    }
}

