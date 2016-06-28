//
//  CategoriesViewController.swift
//  grability
//
//  Created by Pollinion User on 25/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

/**
 This protocol help to send data at the back View.
*/
protocol GetDataFromCategories {
    func getDataFromCategories (id:Int)
}


/**
 This class is a Controller for the view that represent the categories.
 */
class CategoriesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    /// Represent a picker in the view
    @IBOutlet weak var pickerCategories: UIPickerView!
    
    /// It's a array of categories for to use in the picker.
    var categories:[Category]=[]
    
    /// Represent a delegate for conection with protocol GetDataFromCategories
    var delegate:GetDataFromCategories?
    
    /// It's de value selected in the Picker
    var indexForPicker:Int = 0

    /**
        This function rewrite viewDidLoad() for init this View
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Connect data:
        self.pickerCategories.delegate = self
        self.pickerCategories.dataSource = self
    }
    
    /**
     This function rewrite viewWillDisappear() when the view disappear then delegate send id of category to find in the view AppCollectionView
     */
    override func viewWillDisappear(animated: Bool) {
        delegate?.getDataFromCategories(categories[indexForPicker].id)
    }
    
    /**
        This function return number of components in Picker
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
        This function return number of rows in data
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    /**
        The data to return for the row and component (column) that's being passed in
    */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].term
    }
    
    /**
        Use the row to get the selected row from the picker view
        using the row extract the value from your datasource (array[row])
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.indexForPicker = row
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
