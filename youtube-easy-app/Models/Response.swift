//
//  Response.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 18/10/2020.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]?
    
    enum CodingKeys:String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Parse the items
        self.items = try container.decode([Video].self, forKey: .items)
        
    }
}
