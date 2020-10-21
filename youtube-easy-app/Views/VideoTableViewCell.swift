//
//  VideoTableViewCell.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 19/10/2020.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ videoToDisplay:Video) {
        
        self.video = videoToDisplay
        
        // Ensure for an existing video object
        guard self.video != nil else {
            return
        }
        
        // Set the title label
        self.titleLabel.text = video?.title
        
        // Format the date and set the corresponding label
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the thumbnail. Check for validity first...
        guard self.video!.thumbnail != "" else {
            return
        }
        
        // Chech for image cache
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set thumbnail image view
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        // Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in cache
                CacheManager.setVideoCache(url!.absoluteString, data!)
                
                // Check if the URL is not reused by a recycled cell
                if url!.absoluteString != self.video?.thumbnail {
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}
