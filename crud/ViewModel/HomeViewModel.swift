//
//  HomeViewModel.swift
//  crud
//
//  Created by Erick Martins on 02/02/22.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var content = ""
    
    @Published var isNewData = false
    
    @Published var updateItem: Task!
    
    func writeData(context: NSManagedObjectContext){
        
        if updateItem != nil {
            updateItem.content = content
            
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            return
        }
        
        let newTask = Task(context: context)
        newTask.content = content
        
        do {
            try context.save()
            isNewData.toggle()
            content = ""
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editItem(item: Task){
        updateItem = item
        content = item.content!
        isNewData.toggle()
    }
    
    func delete(context: NSManagedObjectContext, task: Task) {
        context.delete(task)
        try! context.save()
    }
}

