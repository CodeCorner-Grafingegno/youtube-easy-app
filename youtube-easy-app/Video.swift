//
//  Video.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 17/10/2020.
//

import Foundation

struct Video: Decodable {
    
    // ATTENTION! BE CAREFUL! Identifier names MUST be exactly matched to the names in JSON object returned by decoder, otherwise the decoding method throws an error. See the JSON structure below.
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case videoId
        case title
        case description
        case thumbnail = "url"
        case published = "publishedAt"
        
    }
    
    init(from decoder: Decoder) throws {
        
        // Get the containers
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        let resourceContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)

        // Parse the title and assign to property
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse description and assign to property
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse the publish data and assign to property
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse the thumbnail URL and assing to property
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)

        // Parse the videoID and assing to property
        self.videoId = try resourceContainer.decode(String.self, forKey: .videoId)
        
    }
    
}

// MARK: - The JSON Structure to parse from YouTube API response

/*
 "items": [{
             "kind": "youtube#playlistItem",
             "etag": "6dBi0UVB8Mnq3BE6gm43YHrrITU",
             "id": "UExNUnFoemNIR3cxYUxvejRwTV9NZzJUZXdtSmNNZzl1YS41Mzk2QTAxMTkzNDk4MDhF",
             "snippet": {
                 "publishedAt": "2020-05-15T14:39:57Z",
                 "channelId": "UC2D6eRvCeMtcF5OGHf1-trw",
                 "title": "How To Make a YouTube App - Lesson 1 - One Day Build",
                 "description": "...",
                 "thumbnails": {
                     "default": {
                         "url": "https://i.ytimg.com/vi/7dGu8IJM_zY/default.jpg",
                         "width": 120,
                         "height": 90
                     },
                     "medium": {
                         "url": "https://i.ytimg.com/vi/7dGu8IJM_zY/mqdefault.jpg",
                         "width": 320,
                         "height": 180
                     },
                     "high": {
                         "url": "https://i.ytimg.com/vi/7dGu8IJM_zY/hqdefault.jpg",
                         "width": 480,
                         "height": 360
                     },
                     "standard": {
                         "url": "https://i.ytimg.com/vi/7dGu8IJM_zY/sddefault.jpg",
                         "width": 640,
                         "height": 480
                     },
                     "maxres": {
                         "url": "https://i.ytimg.com/vi/7dGu8IJM_zY/maxresdefault.jpg",
                         "width": 1280,
                         "height": 720
                     }
                 },
                 "channelTitle": "CodeWithChris",
                 "playlistId": "PLMRqhzcHGw1aLoz4pM_Mg2TewmJcMg9ua",
                 "position": 0,
                 "resourceId": {
                     "kind": "youtube#video",
                     "videoId": "7dGu8IJM_zY"
                 }
             }
         },
 */
