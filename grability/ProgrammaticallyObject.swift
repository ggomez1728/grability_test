//
//  ProgrammaticallyObject.swift
//  grability
//
//  Created by Pollinion User on 26/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class ProgrammaticallyObject: NSObject {
    
    func createLabel(text text:String, x:Float, y:Float, width:Float, height:Float, font:String, size:Float ) -> UILabel {
        let label = UILabel(frame: CGRectMake(CGFloat(x), CGFloat(y),CGFloat(width), CGFloat(height)))
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.font =  UIFont (name:font, size: CGFloat(size))
        label.numberOfLines = 0
        label.textColor = UIColor.blackColor()
        return label
    }
    func createImage(image image:UIImage, x:Float, y:Float, width:Float, height:Float) -> UIImageView {
        let picture = UIImageView(frame: CGRectMake(CGFloat(x), CGFloat(y),CGFloat(width), CGFloat(height))) // set as you want
        picture.image = image
        picture.layer.cornerRadius = picture.frame.size.width / 3
        picture.clipsToBounds = true
        picture.layer.borderWidth = 3.0
        picture.layer.borderColor = UIColor.whiteColor().CGColor
        return picture
    }

}
