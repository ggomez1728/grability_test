//
//  DataPersistence.swift
//  grability
//
//  Created by Pollinion User on 24/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData

/**
 This class representing Drive for save data in Core Data.
 */
class DataPersistence: NSObject {
    
    /// Represent the context for manage Core Data of application.
    var context:NSManagedObjectContext?
    
    /**
     This is a constructor of class.
     */
    /// - Parameters : Represent elements.
    /// - Parameter context:  Receive the context of Application.
    init(context:NSManagedObjectContext?){
        self.context = context
    }
    
    /**
     This function allows save data persistence.
     */
    /// - Parameters : Represent elements.
    /// - Parameter apps: It's a array of type App to will save.
    func saveApps(apps:[App]){
        for app in apps{
            if (!self.testCategoryExists(app.category.id)){
                //not exist category then save it
                self.saveCategory(app)
            }
            if (!self.testAppExists(app.id)){
                //not exist app then save it
                self.saveApp(app)
            }
        }
    }
    
    /**
     This function give the categories saved in Core Data.
     */
    ///  - Returns: An Array of Categories.
    func getCategories() -> [Category] {
        var categories:[Category] = []
        categories.append(Category(id: 0, term: "All"))
        let AppEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.context!)
        let requestApp = AppEntity?.managedObjectModel.fetchRequestTemplateForName("reqCategories")
        do{
            let categoriesEntity = try self.context?.executeFetchRequest(requestApp!)
            for readCategoryEntity in categoriesEntity!{
                let id = readCategoryEntity.valueForKey("id")!.integerValue
                let term = readCategoryEntity.valueForKey("term")! as! String
                let readCategory = Category(id: id, term: term)
                categories.append(readCategory)
            }
        }
        catch{
            print("Fail reading coreData <<getCategories>>")
        }
        return categories
    }
    
    /**
     This function give it all Apps saved in Core Data.
     */
    ///  - Returns: An Array of Apps.
    func getAllApps() -> [App] {
        var apps:[App]=[]
        let AppEntity = NSEntityDescription.entityForName("App", inManagedObjectContext: self.context!)
        let requestApp = AppEntity?.managedObjectModel.fetchRequestTemplateForName("reqApps")
        do{
            let AppsEntity = try self.context?.executeFetchRequest(requestApp!)
            for readAppEntity in AppsEntity!{
                let id = readAppEntity.valueForKey("id")!.integerValue
                let title = readAppEntity.valueForKey("title")! as! String
                let summary = readAppEntity.valueForKey("summary")! as! String
                let rights = readAppEntity.valueForKey("rights")! as! String
                let url_image = readAppEntity.valueForKey("url_image")! as! String
                var image : UIImage? = nil
                if readAppEntity.valueForKey("image") != nil {
                    image = UIImage(data: readAppEntity.valueForKey("image") as! NSData)
                }
                let id_category = readAppEntity.valueForKey("id_category")!.integerValue
                let readApp = App(id: id, title: title, summary: summary, id_category: id_category, term: "", rights: rights, url_image: url_image, image: image)
                apps.append(readApp)
            }
        }
        catch{
            print("Fail reading coreData <<getAllApps>>")
        }
        return apps
    }
    
    /**
     This function give it Apps of category selected and saved in Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter idCategory: It's a id of Category selected for sort data.
    
    ///  - Returns: An Array of Apps.
    func getAppsForCategory(id_category id_category:Int) -> [App] {
        var apps:[App]=[]
        let AppEntity = NSEntityDescription.entityForName("App", inManagedObjectContext: self.context!)
        let requestCategory = AppEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqAppsForCategory", substitutionVariables: ["id_category": id_category])

        do{
            let AppsEntity = try self.context?.executeFetchRequest(requestCategory!)
            for readAppEntity in AppsEntity!{
                let id = readAppEntity.valueForKey("id")!.integerValue
                let title = readAppEntity.valueForKey("title")! as! String
                let summary = readAppEntity.valueForKey("summary")! as! String
                let rights = readAppEntity.valueForKey("rights")! as! String
                let url_image = readAppEntity.valueForKey("url_image")! as! String
                var image : UIImage? = nil
                if readAppEntity.valueForKey("image") != nil {
                    image = UIImage(data: readAppEntity.valueForKey("image") as! NSData)
                }
                let id_category = readAppEntity.valueForKey("id_category")!.integerValue
                let readApp = App(id: id, title: title, summary: summary, id_category: id_category, term: "", rights: rights, url_image: url_image, image: image)
                apps.append(readApp)
            }
        }
        catch{
            print("Fail reading coreData <<getAppsForCategory>>")
        }
        return apps
    }
    
    //Privates Functions 
    
    
    /**
     This function check if the category did has saved in Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter id: It's a id of Category selected to find.
    
    ///  - Returns: Boolean response.
    private func testCategoryExists(id: Int)->Bool{
        var response: Bool = false
        let categoryEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.context!)
        let requestCategory = categoryEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqCategory", substitutionVariables: ["id":id])
        do{
            let categoryEntityResponse = try self.context?.executeFetchRequest(requestCategory!)
            if (categoryEntityResponse?.count > 0){
                response = true
            }
        }
        catch{
            print("Fail request category exist")
        }
        return response
    }
    
    /**
     This function check if the App did has saved in Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter id: It's a id of App selected to find.
    
    ///  - Returns: Boolean response.
    private func testAppExists(id:Int)->Bool{
        var response:Bool = false
        let AppEntity = NSEntityDescription.entityForName("App", inManagedObjectContext: self.context!)
        let requestApp = AppEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqApp", substitutionVariables: ["id":id])
        do{
            let appEntityResponse = try self.context?.executeFetchRequest(requestApp!)
            if(appEntityResponse?.count > 0){
                response = true
            }
        }
        catch{
            print("Fail request app exist")
        }
        return response
    }
    
    /**
     This function save the category in Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter app: It's a App with datas of category to save.
    private func saveCategory(app:App){
        let newCategoryEntity = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: self.context!)
        //save elements of new route
        newCategoryEntity.setValue(app.category.id, forKey: "id")
        newCategoryEntity.setValue(app.category.term, forKey: "term")
        do{
            try self.context!.save()
        }
        catch{
            print("Fail save category")
        }
    }
    
    /**
     This function save the app in Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter app: It's a App to save.
    private func saveApp(app:App){
        let categoryEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.context!)
        let requestCategory = categoryEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqCategory", substitutionVariables: ["id":app.category.id])
        do{
            let categoryEntityResponse = try self.context?.executeFetchRequest(requestCategory!)
            let editCategory = categoryEntityResponse?.first
            editCategory?.setValue(self.saveAppEntity(app), forKey: "has_many")
            try self.context!.save()
        }
        catch{
            print("Fail request category exist")
        }
    }
    /**
     This function save the app entity for Core Data.
     */
    /// - Parameters : Represent elements.
    /// - Parameter app: It's a App with datas to save.
    ///  - Returns: NSObject response for relationship hasMany.

    private func saveAppEntity(app:App)->NSObject{
        let appEntity = NSEntityDescription.insertNewObjectForEntityForName("App", inManagedObjectContext: self.context!)
        appEntity.setValue(app.id , forKey: "id")
        appEntity.setValue(app.category.id, forKey: "id_category")
        appEntity.setValue(app.title, forKey: "title")
        appEntity.setValue(app.rights, forKey: "rights")
        appEntity.setValue(app.summary, forKey: "summary")
        appEntity.setValue(app.url_image, forKey: "url_image")
        let imageRequest = DataRequest()
        let image = imageRequest.getImage(app.url_image)
        appEntity.setValue(UIImagePNGRepresentation(image!) , forKey: "image")
        return appEntity
    }

}
