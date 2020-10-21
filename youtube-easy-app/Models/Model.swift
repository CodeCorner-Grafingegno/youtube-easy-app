//
//  Model.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 17/10/2020.
//

import Foundation

// Defines the protocol to wich the model has to conform in order to handle the asyncronous fetching of video data
protocol ModelDelegate {
    
    func videosFetched(_ videos:[Video])
}


class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos() {
        
        // Create the URL object
        let url = URL(string: Constants.API_URL)
        
        // URL can be nil, so check against this condition
        guard url != nil else { return }
        
        // Get a URL Session
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil || data == nil {
                print("There is an error in Data Task")
                return
            }
            
            // Parse the video object
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601     //Rule to convert Date type when fetching Date string
            
            do {
                let parsedJSONObject = try decoder.decode(Response.self, from: data!)
                // dump(parsedJSONObject)
                
                // Check for video items not nil
                if parsedJSONObject.items != nil {
                    
                    DispatchQueue.main.async {
                        // Call the delegate method to fetch the videos
                        self.delegate?.videosFetched(parsedJSONObject.items!)
                    }
                }
                
         
            } catch {
                // Catch the error in decoding data
                print("There is an error in decoding data.")
            }

        }
        
        // Kick off the data task
        dataTask.resume()
        
    }
}
