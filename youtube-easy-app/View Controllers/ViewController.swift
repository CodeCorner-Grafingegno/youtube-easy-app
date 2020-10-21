//
//  ViewController.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 16/10/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set itself as datasource and delegate fot table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set itaself as delegate for the model
        model.delegate = self
        
        model.getVideos()
    }
    
    // Prepare the data to pass to the incoming segue (view). We have to pass the video.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Check if a video has been selected
        guard tableView.indexPathForSelectedRow != nil else {return}
        
        // Get a reference to the selected video
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        // Get the reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        detailVC.video = selectedVideo
    }

    // MARK: - Model Delegate methods
    
    func videosFetched(_ videos: [Video]) {
        
        // Set the video property
        self.videos = videos
        
        tableView.reloadData()
    }
    

    // MARK: - Table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        // Configure cell
        let video = self.videos[indexPath.row]
        cell.setCell(video)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
