//
//  CategoriesViewController.swift
//  grability
//
//  Created by Pollinion User on 25/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

protocol GetDataFromCategories {
    func getDataFromCategories (id:Int)
}

class CategoriesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerCategories: UIPickerView!
    var categories:[Category]=[]
    var delegate:GetDataFromCategories?
    var indexForPicker:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect data:
        self.pickerCategories.delegate = self
        self.pickerCategories.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        delegate?.getDataFromCategories(categories[indexForPicker].id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].term
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
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
