//
//  AppsCollectionView.swift
//  grability
//
//  Created by Pollinion User on 25/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class AppsCollectionView: UICollectionViewController {

    var viewType:String = "List"
    
    var context :NSManagedObjectContext? = nil

    var apps:[App] = []
    var indexApp:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        collectionView?.allowsMultipleSelection = false

        self.getTypeDevice()
        self.configLayout()

        self.context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let url_string:String = "https://itunes.apple.com/us/rss/topfreeapplications"
        let data_web :DataRequest = DataRequest()
        let persistence = DataPersistence(context: self.context)
        //x_image is 1X = 1, 2X = 2, 3X = 3
        let data_t = data_web.getData(x_image: 2, url_string: url_string, numberOfElements: 20)

        if (data_t.response == "fail") {
            let alert = UIAlertController(title: "Error de conexión", message: "No hay conexión a internet o el servidor no está accesible.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let apps = data_t.apps
            persistence.saveApps(apps)
        }
        persistence.saveApps(apps)
        self.apps = persistence.getAllApps()

    }
    
    func configLayout()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        // (note, it's critical to actually set the layout to that!!)
        collectionView!.collectionViewLayout = layout
    }
    
    func getTypeDevice(){
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
            self.viewType = "Grid"
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.apps.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppViewCell
        
        // Configure the cell
        //cell.titleApp.text = self.apps[indexPath.item].title
            
            cell.imageApp.image = self.apps[indexPath.item].image!
            cell.imageApp.layer.cornerRadius = cell.imageApp.frame.size.width / 3
            cell.imageApp.clipsToBounds = true
            cell.imageApp.layer.borderWidth = 3.0
            cell.imageApp.layer.borderColor = UIColor.whiteColor().CGColor

            cell.titleApp.text =  self.apps[indexPath.item].title
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if (self.viewType == "List") {
            return CGSize(width: CGRectGetWidth(collectionView.frame), height: 120)
        }
        return CGSize(width: ((CGRectGetWidth(collectionView.frame)/3)-2), height: 120)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as? detailViewController
        nextViewController?.detailApp=apps[indexPath.item]
        self.navigationController?.pushViewController(nextViewController!, animated: true)
        
    }
    
    @IBAction func getCategory(sender: AnyObject) {
        let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CategoriesViewController") as? CategoriesViewController
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }
 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "idDetail"){
            let cc = segue.destinationViewController as! detailViewController
            
    //     cc.route = self.routes[ip!.row]
        }
    }
*/
 
}
