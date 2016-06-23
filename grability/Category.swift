//
//  Category.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id_category: Int
    var term: String
    init(id_category:Int, term:String) {
        self.id_category = id_category
        self.term = term
    }
}
