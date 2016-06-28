//
//  Category.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

/**
 This class representing each Category.
*/
class Category: NSObject {

    /// This is a identifier of Category
    var id: Int
    
    /// This is a name of  each Category
    var term: String
    
    /**
    It allows to build an object of this class
    */
    /// - Parameters : Represent elements
    /// - Parameter id:  A identifier of Category.
    /// - Parameter term:  Name of Category.

    init(id:Int, term:String) {
        self.id = id
        self.term = term
    }
}
