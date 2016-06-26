//
//  App.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class App: NSObject {
    var id: Int
    var title : String
    var summary: String
    var category: Category
    var rights: String
    var image : UIImage?
    var url_image:String
    init(id:Int, title: String, summary:String, id_category:Int, term:String, rights: String, url_image : String, image : UIImage?=nil) {
        self.id = id
        self.title = title
        self.summary = summary
        self.category = Category(id: id_category, term: term)
        self.rights = rights
        self.url_image = url_image
        self.image = image

    }
    
    func setImageForApp(image : UIImage){
        self.image = image
    }
}
