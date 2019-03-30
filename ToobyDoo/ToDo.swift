//
//  ToDo.swift
//  ToobyDoo
//
//  Created by student5 on 3/23/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import Foundation


struct ToDo : Codable {
    var title : String
    var isComplete : Bool
    var dueDate : Date
    var notes : String?
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL)
            else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from:codedToDos)
    } //end loadToDos
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "1st ToDo", isComplete: false, dueDate: Date(), notes: "Notes here")
        let todo2 = ToDo(title: "2nd ToDo", isComplete: false, dueDate: Date(), notes: "Notes here")
        let todo3 = ToDo(title: "3rd ToDo", isComplete: false, dueDate: Date(), notes: "Notes here")
        
        return [todo1, todo2, todo3]
    } // end loadSampleToDos
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    } // end saveToDos
    
    static let dueDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }() // end dueDateFormatter
    
} // end ToDo
