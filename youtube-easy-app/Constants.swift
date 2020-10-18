//
//  Constants.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 17/10/2020.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyDt1tEXEesAuDg_g7LBErBEdTWc35Dgy9s"
    static var PLAYLIST_ID = "PLMRqhzcHGw1aLoz4pM_Mg2TewmJcMg9ua"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"

}
