//
//  CoreManager.swift
//  Notes
//
//  Created by Daniil Kim on 22.07.2024.
//

import Foundation
import CoreData

//Singleton
class CoreManager{
    static let shared = CoreManager()
    var notes = [Note]()
    
    private init() {
        fetchAllNotes()
    }
    
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //Fetch func
    
    func fetchAllNotes(){
        let request = Note.fetchRequest()
        if let notes = try? persistentContainer.viewContext.fetch(request) {
            self.notes = notes
        }
    }
    
    //Add func
    
    func addNewNote(title: String, text:String){
        let note = Note(context: persistentContainer.viewContext)
        note.id = UUID().uuidString
        note.title = title
        note.text = text
        note.date = Date()
        
        saveContext()
        fetchAllNotes()
    }
}
