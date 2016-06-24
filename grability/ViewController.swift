//
//  ViewController.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let data_web :DataRequest = DataRequest(url_string: "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json")
        //x_image is 1X = 1, 2X = 2, 3X = 3
        let data_t = data_web.getData(x_image: 1)
        let apps = data_t.apps
        print("\(apps[0].title)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

