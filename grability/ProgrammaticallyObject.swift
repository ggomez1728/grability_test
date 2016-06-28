//
//  ProgrammaticallyObject.swift
//  grability
//
//  Created by Pollinion User on 26/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
/**
 alternative Class for create funny images
*/
 class ProgrammaticallyObject: NSObject {
    
    /**
     This function create a label for view.
     */
    /// - Parameters : Represent elements.
    /// - Parameter image: Receive a sad image.
    /// - Parameter x: Position of label in x of cartesian coordinate system.
    /// - Parameter y:  Position of label in y of cartesian coordinate system
    /// - Parameter width: It's a width of label.
    /// - Parameter height: It's a height of label.
    
    ///  - Returns: UILabel return a funny label.
    
    func createLabel(text text:String, x:Float, y:Float, width:Float, height:Float, font:String, size:Float ) -> UILabel {
        let label = UILabel(frame: CGRectMake(CGFloat(x), CGFloat(y),CGFloat(width), CGFloat(height)))
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.font =  UIFont (name:font, size: CGFloat(size))
        label.numberOfLines = 0
        label.textColor = UIColor.blackColor()
        return label
    }
    
    /**
     This function create a image for view.
     */
    /// - Parameters : Represent elements.
    /// - Parameter image: Receive a sad image.
    /// - Parameter x: Position of image in x of cartesian coordinate system.
    /// - Parameter y:  Position of image in y of cartesian coordinate system
    /// - Parameter width: It's a width of image.
    /// - Parameter height: It's a height of image.

    ///  - Returns: UIImageView return a funny image .
    
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
