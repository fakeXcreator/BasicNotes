//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Daniil Kim on 22.07.2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

//Here will be our update and delete func (because that's an easy way)
extension Note : Identifiable {

    func updateNote(newTitle: String, newText: String){
        self.title = newTitle
        self.text = newText
        self.date = Date()
        
        try? managedObjectContext?.save
    }
    
    func deleteNote(){
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
