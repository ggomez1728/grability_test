//
//  AppViewCell.swift
//  grability
//
//  Created by Pollinion User on 25/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

/**
    This class help to represent each cell of collection in the view AppsCollectionView
*/
class AppViewCell: UICollectionViewCell {
    
    ///This is a reference of Image in Cell
    @IBOutlet weak var imageApp: UIImageView!
    
    ///This is a reference of label in Cell that represent the name of App
    @IBOutlet weak var titleApp: UILabel!
    
}
