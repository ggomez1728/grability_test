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
    init(id:Int, title: String, summary:String, id_category:Int, term:String, rights: String, image : UIImage?) {
        self.id = id
        self.title = title
        self.summary = summary
        self.category = Category(id: id_category, term: term)
        self.rights = rights
        if (image != nil){
            self.image = image!
        }
    }
}
