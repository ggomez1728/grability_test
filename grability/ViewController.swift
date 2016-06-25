//
//  ViewController.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context :NSManagedObjectContext? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

        let data_web :DataRequest = DataRequest(url_string: "https://itunes.apple.com/us/rss/topfreeapplications/limit=5/json")
        //x_image is 1X = 1, 2X = 2, 3X = 3
        let data_t = data_web.getData(x_image: 1)
        let apps = data_t.apps

        let persistence = DataPersistence(apps: apps, context: self.context)
        persistence.saveApps(apps)
        let allDatos = persistence.getAllApps()
        for dato in allDatos{
            print(dato.category.id)
        }
        let DatosForCategory = persistence.getAppsForCategory(id_category: 6008)
        for dato in DatosForCategory{
            print(dato.category.id)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

