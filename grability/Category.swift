//
//  Category.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id: Int
    var term: String
    init(id:Int, term:String) {
        self.id = id
        self.term = term
    }
}
