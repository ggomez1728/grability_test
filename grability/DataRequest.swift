//
//  DataRequest.swift
//  grability
//
//  Created by Pollinion User on 23/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class DataRequest: NSObject {
    var url_string: String
    init(url_string: String) {
        self.url_string = url_string
    }
    func getData(x_image x_image:Int)->(apps: [App], response: String){
        var apps:[App]=[]
        let url = NSURL(string: self.url_string)
        let data_json = NSData(contentsOfURL: url!)
        if (data_json == nil){
            print("No hay conexión a internet o el servidor no está accesible.")
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
                                var element_image: UIImage?
                                if (images.count > 0){
                                    let dic_image = images[x_image-1] as! NSDictionary
                                    let image_url = dic_image["label"] as! NSString as String
                                    if (image_url != ""){
                                        let url_img = NSURL(string: image_url)
                                        let data_img = NSData(contentsOfURL: url_img!)
                                        //make sure your image in this url does exist, otherwise unwrap in a if let check
                                        element_image = UIImage(data: data_img!)!
                                    }
                                }
                                //load app in array
                                apps.append(App(id: Int(element_id)!, title: element_title, summary: element_summary, id_category: Int(element_id_category)!, term: element_category, rights: element_rights, image: element_image))
                            }
                        }
                        
                    }
                    else{
                        print("fail")
                    }
                }

                
            }
            catch{
                
            }
            
        }
        return (apps, "ok")
    }
}
