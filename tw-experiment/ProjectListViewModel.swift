//
//  TaskListViewModel.swift
//  tw-experiment
//
//  Created by TW-LostSeaWay on 10/10/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import CoreData

class ProjectListViewModel {
    let managedContext: NSManagedObjectContext
    let entity: NSEntityDescription
    var projects = [Project]()
    
    init(context: NSManagedObjectContext) {
        self.managedContext = context
        entity =  NSEntityDescription.entity(forEntityName: "Project",in:managedContext)!
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            let results = try managedContext.fetch(fetchRequest)
            projects = results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func createProject(name: String) -> Bool {
        let newProject = Project(context: managedContext)
        newProject.name = name
        do {
            try managedContext.save()
            reloadData()
        } catch {
            return false
        }
        return true
        
    }
}
