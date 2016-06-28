//
//  detailViewController.swift
//  grability
//
//  Created by Pollinion User on 26/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import Material


/**
    This class is a Controller for the view that represent the collections of Apps.
 */
class detailViewController: UIViewController {
   
    ///Represent de App for view Detail.
    var detailApp:App? = nil
    
    ///This object is used in the image funny
    let object = ProgrammaticallyObject()

    /**
     This function rewrite viewDidLoad() for init this View
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        let widthView = Float(UIScreen.mainScreen().bounds.width)
        let heightView = Float(UIScreen.mainScreen().bounds.height - 20)
        prepareLargeCardViewExample()
        let imageApp =  object.createImage(image: detailApp!.image!, x: (widthView/2)-50, y: 110, width: 100, height: 100 )
        self.view.addSubview(imageApp);
        let rightsApp = object.createLabel(text: "Grability Test", x: 10, y: heightView-33, width: widthView-20, height: 63, font: "HelveticaNeue", size: 14)
        self.view.addSubview(rightsApp)
        
        // Do any additional setup after loading the view.
    }

    /**
     This function create programmatical object CardView.
     */
    private func prepareLargeCardViewExample() {
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(10, 100, view.bounds.width - 32, view.bounds.height - 140))
        cardView.pulseColor = MaterialColor.blueGrey.base
        cardView.depth = .Depth1
        view.addSubview(cardView)
        
        let contentView: MaterialView = MaterialView()
        contentView.backgroundColor = MaterialColor.clear
        cardView.addSubview(contentView)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.text = self.detailApp!.title
        titleLabel.numberOfLines = 0

        titleLabel.textColor = MaterialColor.blueGrey.darken4
        titleLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(titleLabel)
        
        let moreButton: IconButton = IconButton()
        moreButton.contentEdgeInsetsPreset = .None
        moreButton.pulseColor = MaterialColor.blueGrey.darken4
        moreButton.tintColor = MaterialColor.blueGrey.darken4
        contentView.addSubview(moreButton)
        
        let detailLabel: UILabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .ByTruncatingTail
        detailLabel.font = RobotoFont.regularWithSize(12)
        detailLabel.text = detailApp!.summary
        detailLabel.textColor = MaterialColor.blueGrey.darken4
        detailLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(detailLabel)
        
        let rightsLabel: UILabel = UILabel()
        rightsLabel.font = RobotoFont.regularWithSize(12)
        rightsLabel.text = detailApp!.rights
        rightsLabel.textColor = MaterialColor.blueGrey.darken4
        rightsLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(rightsLabel)
        
        contentView.grid.rows = 4
        contentView.grid.offset.rows = 2
        cardView.grid.axis.direction = .None
        cardView.grid.spacing = 2
        cardView.grid.views = [
            contentView
        ]
        
        titleLabel.grid.rows = 5
        titleLabel.grid.columns = 8
        moreButton.grid.rows = 3
        moreButton.grid.columns = 2
        moreButton.grid.offset.columns = 10
        detailLabel.grid.rows = 25
        detailLabel.grid.offset.rows = 5
        rightsLabel.grid.rows = 3
        rightsLabel.grid.columns = 8
        rightsLabel.grid.offset.rows = 30
        contentView.grid.spacing = 8
        contentView.grid.axis.direction = .None
        contentView.grid.contentInsetPreset = .Square3
        contentView.grid.views = [
            titleLabel,
            moreButton,
            detailLabel,
            rightsLabel
        ]
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
