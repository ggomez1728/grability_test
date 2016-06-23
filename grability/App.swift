//
//  App.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class App: NSObject {
    var name : String
    var summary: String
    var id_category: Int
    var rights: String
    var image : UIImage?
    init(name: String, summary:String, id_category:Int, rights: String, image : UIImage?) {
        self.name = name
        self.summary = summary
        self.id_category = id_category
        self.rights = rights
        if (image != nil){
            self.image = image!
        }
    }
}
