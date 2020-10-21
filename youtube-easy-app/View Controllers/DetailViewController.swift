//
//  DetailViewController.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 20/10/2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var video:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Clear the text field
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        // Check for consistency of video
        guard video != nil else {
            return
        }
        
        // Create the URL
        let embedURLString = Constants.YT_EMBED_URL + video!.videoId
        let url = URL(string: embedURLString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        // Set the title for the video
        titleLabel.text = video!.title
        
        // Set the date, format it...
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // Set the description
        textView.text = video!.description
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
