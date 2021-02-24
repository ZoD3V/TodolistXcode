//
//  ToDoListItem.swift
//  TodoAppsZed
//
//  Created by zero on 16/02/21.
//

import Foundation
import CoreData

//class untuk memanage object
class ToDoListItem: NSManagedObject,Identifiable{
    @NSManaged var name:String?
    @NSManaged var createdAt:Date?
}
//extension untuk mendapatkan semua data user,menyimpannya dan mengembalikannya
extension ToDoListItem{
    static func getAllToDoListItem() -> NSFetchRequest<ToDoListItem>{
        let request: NSFetchRequest<ToDoListItem> =
            ToDoListItem.fetchRequest() as!
        NSFetchRequest<ToDoListItem>
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sort]
        
        return request
    }
}
