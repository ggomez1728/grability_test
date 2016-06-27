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
        let url_string:String = "https://itunes.apple.com/us/rss/topfreeapplications"
        let data_web :DataRequest = DataRequest()
        //x_image is 1X = 1, 2X = 2, 3X = 3
        let data_t = data_web.getData(x_image: 1, url_string: url_string, numberOfElements: 20, numberOfPage: 1)
        let persistence = DataPersistence(context: self.context)
        if (data_t.response == "fail") {
            let alert = UIAlertController(title: "Error conexión", message: "No hay conexión a internet o el servidor no está accesible.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let apps = data_t.apps
            persistence.saveApps(apps)
        }

        let allDatos = persistence.getAllApps()
        for dato in allDatos{
            print(dato.category.id)
        }
        let DatosForCategory = persistence.getAppsForCategory(id_category: 6008)
        for dato in DatosForCategory{
            print(dato.rights)
        }
        let DatosCategories = persistence.getCategories()
        for dato in DatosCategories{
            print("\(dato.id)>>\(dato.term)")
        }
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            // It's an iPhone
            print("es un iPhone")
        case .Pad:
            // It's an iPad
            print("es un iPad")
            
        default:
            // Uh, oh! What could it be?
            print("error")
            
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

