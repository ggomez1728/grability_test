//
//  DataRequest.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class DataRequest: NSObject {

    func getData(x_image x_image:Int, url_string: String, numberOfElements:Int, numberOfPage:Int = 1)->(apps: [App], response: String){

        var apps:[App]=[]
        let url = NSURL(string:"\(url_string)/limit=\(numberOfElements)/json?page=\(numberOfPage)")
        let data_json = NSData(contentsOfURL: url!)
        if (data_json == nil){
            print("No hay conexión a internet o el servidor no está accesible.")
            return (apps, "fail")
        }
        else{
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data_json!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                if (json["feed"] != nil) {
                    let dic_feed = json["feed"] as! NSDictionary
                    if (dic_feed["entry"] != nil) {
                        let entries = dic_feed["entry"] as! NSArray
                        if (entries.count > 0) {
                            for element in entries {
                                //load id
                                let dic_id = element["id"] as! NSDictionary
                                let dic_attributes = dic_id["attributes"] as! NSDictionary
                                let element_id = dic_attributes["im:id"] as! NSString as String
                                //load title
                                let dic_title = element["title"] as! NSDictionary
                                let element_title = dic_title["label"] as! NSString as String
                                //load summary
                                let dic_summary = element["summary"] as! NSDictionary
                                let element_summary = dic_summary["label"] as! NSString as String
                                //load rights
                                let dic_rights = element["rights"] as! NSDictionary
                                let element_rights = dic_rights["label"] as! NSString as String
                                
                                //load categories
                                let dic_category = element["category"] as! NSDictionary
                                let dic_cat_attributes = dic_category["attributes"] as! NSDictionary
                                let element_id_category = dic_cat_attributes["im:id"] as! NSString as String
                                let element_category = dic_cat_attributes["label"] as! NSString as String
                                //load image
                                let images = element["im:image"] as! NSArray
                                var url_image:String = ""
                                if (images.count > 0){
                                    let dic_image = images[x_image-1] as! NSDictionary
                                    url_image =  dic_image["label"] as! NSString as String
                                }
                                //load app in array
                                apps.append(App(id: Int(element_id)!, title: element_title, summary: element_summary, id_category: Int(element_id_category)!, term: element_category, rights: element_rights, url_image: url_image))
                            }
                        }
                    }
                    else{
                        print("fail read a image")
                    }
                }
            }
            catch{
             print("fail in reading Json")
            }
        }
        return (apps, "ok")
    }
    
    func getImage(url_image:String) -> UIImage? {
        var element_image: UIImage?
        if (url_image != ""){
            let url_img = NSURL(string: url_image)
            let data_img = NSData(contentsOfURL: url_img!)
            //make sure your image in this url does exist, otherwise unwrap in a if let check
            element_image = UIImage(data: data_img!)!
        }
        return element_image
    }
}
