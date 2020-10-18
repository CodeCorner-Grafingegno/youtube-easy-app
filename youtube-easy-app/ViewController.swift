//
//  ViewController.swift
//  youtube-easy-app
//
//  Created by Gianluca Gandini on 16/10/2020.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
    }


}
