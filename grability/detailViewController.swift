//
//  detailViewController.swift
//  grability
//
//  Created by Pollinion User on 26/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit


class detailViewController: UIViewController {

    var test2:String=""
    var detailApp:App? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let object=ProgrammaticallyObject()
        let widthView = Float(UIScreen.mainScreen().bounds.width)
        let heightView = Float(UIScreen.mainScreen().bounds.height - 20)

        let spaceObjects = heightView - (310)
        
        let titleApp = object.createLabel(text: detailApp!.title, x: 10, y: 60, width: widthView-20, height: 63, font: "HelveticaNeue-Bold", size: 18)
        self.view.addSubview(titleApp)
        
        
        let imageApp =  object.createImage(image: detailApp!.image!, x: (widthView/2)-50, y: 133, width: 100, height: 100 )
        self.view.addSubview(imageApp);
        
        let summaryApp = object.createLabel(text: detailApp!.summary, x: 10, y: 263, width: widthView-20, height: spaceObjects, font: "HelveticaNeue", size: 17)
        self.view.addSubview(summaryApp)

        let rightsApp = object.createLabel(text: detailApp!.rights, x: 10, y: heightView-43, width: widthView-20, height: 63, font: "HelveticaNeue", size: 14)
        self.view.addSubview(rightsApp)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
