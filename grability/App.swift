//
//  App.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

/**
This class representing each App.
*/

class App: NSObject {
    
    /// This is a identifier of App.
    var id: Int
    
    /// The title represent the name of App.
    var title : String
    
    /// Summary is a abstract for App.
    var summary: String
    
    /// Represent each category (see: Category Class).
    var category: Category
    
    /// This refers to copyRight.
    var rights: String
    
    /// Show the image that represent each App.
    var image : UIImage?
    
    /// It's a Url of image.
    var url_image:String
    
    /**
     It allows to build an object of this class.
     */
    /// - Parameters : Represent elements.
    /// - Parameter id:  A identifier of App.
    /// - Parameter title:  Name of App.
    /// - Parameter summary:  Name of App.
    /// - Parameter idCategory:  Id of Category.
    /// - Parameter term:  name of Category.
    /// - Parameter rights:  copyRights of App.
    /// - Parameter urlImage:  Url of App to save.
    /// - Parameter image:  Image of App.
    init(id:Int, title: String, summary:String, id_category:Int, term:String, rights: String, url_image : String, image : UIImage?=nil) {
        self.id = id
        self.title = title
        self.summary = summary
        self.category = Category(id: id_category, term: term)
        self.rights = rights
        self.url_image = url_image
        self.image = image
    }
    
    /**
      It's allow to save an image in this object.
     */
    /// - Parameters : Represent elements.
    /// - Parameter image:  Send a Image of App.
    func setImageForApp(image : UIImage){
        self.image = image
    }
}
