//
//  DataPersistence.swift
//  grability
//
//  Created by Pollinion User on 24/06/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit
import CoreData

class DataPersistence: NSObject {
    var context:NSManagedObjectContext?
    init(apps:[App], context:NSManagedObjectContext?){
        self.context = context
    }
    
    func saveApps(apps:[App]){
        for app in apps{
            if (!self.testCategoryExists(app.category.id)){
                //not exist category then save it
                self.saveCategory(app)
            }
            if (!self.testAppExists(app.id)){
                self.saveApp(app)
            }
        }
    }
    
    func getAllApps() -> [App] {
        var apps:[App]=[]
        let AppEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.context!)
        let requestCategory = AppEntity?.managedObjectModel.fetchRequestTemplateForName("reqApps")
        do{
            let AppsEntity = try self.context?.executeFetchRequest(requestCategory!)
            for readAppEntity in AppsEntity!{
                let id = readAppEntity.valueForKey("id")!.integerValue
                let title = readAppEntity.valueForKey("title")! as! String
                let summary = readAppEntity.valueForKey("summary")! as! String
                let rights = readAppEntity.valueForKey("rights")! as! String
                var image : UIImage? = nil
                if readAppEntity.valueForKey("image") != nil {
                    image = UIImage(data: readAppEntity.valueForKey("image") as! NSData)
                }
                let id_category = readAppEntity.valueForKey("id_category")!.integerValue
                let readApp = App(id: id, title: title, summary: summary, id_category: id_category, term: "", rights: rights, image: image)
                apps.append(readApp)
            }
            
        }
        catch{
            print("Fail reading coreData")
        }
    
        return apps
    }
    
    func getAppsForCategory(id_category id_category:Int) -> [App] {
        var apps:[App]=[]
        let AppEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.context!)
        let requestCategory = AppEntity?.managedObjectModel.fetchRequestFromTemplateWithName("reqAppsForCategory", substitutionVariables: ["id_category": id_category])

        do{
            let AppsEntity = try self.context?.executeFetchRequest(requestCategory!)
            for readAppEntity in AppsEntity!{
                let id = readAppEntity.valueForKey("id")!.integerValue
                let title = readAppEntity.valueForKey("title")! as! String
                let summary = readAppEntity.valueForKey("summary")! as! String
                let rights = readAppEntity.valueForKey("rights")! as! String
                var image : UIImage? = nil
                if readAppEntity.valueForKey("image") != nil {
                    image = UIImage(data: readAppEntity.valueForKey("image") as! NSData)
                }
                let id_category = readAppEntity.valueForKey("id_category")!.integerValue
                let readApp = App(id: id, title: title, summary: summary, id_category: id_category, term: "", rights: rights, image: image)
                apps.append(readApp)
            }
        }
        catch{
            print("Fail reading coreData")
        }
        return apps
    }
    
    //Privates Functions 
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

    private func saveAppEntity(app:App)->NSObject{
        let appEntity = NSEntityDescription.insertNewObjectForEntityForName("App", inManagedObjectContext: self.context!)
        appEntity.setValue(app.id , forKey: "id")
        appEntity.setValue(app.category.id, forKey: "id_category")
        appEntity.setValue(app.title, forKey: "title")
        appEntity.setValue(app.rights, forKey: "rights")
        appEntity.setValue(app.summary, forKey: "summary")
        appEntity.setValue(UIImagePNGRepresentation(app.image!) , forKey: "image")
        return appEntity
    }

}