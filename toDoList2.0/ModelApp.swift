//
//  ModelFile.swift
//  toDoList2.0
//
//  Created by Жеребцов Данил on 17.05.2021.
//

import Foundation
import UIKit
// класс для создания отдельного события
class Item {
    var string: String
    var completion: Bool
    var increacedImportance: Bool
    
    init(string: String, completion: Bool, increacedImportance: Bool ) {
        self.string = string
        self.completion = completion
        self.increacedImportance = increacedImportance
    }
}

// класс модели, отвечающий за хранение данных и за операции с ними
class Model {
    var arrayItems = [
        Item(string: "Buy food", completion: false, increacedImportance: false),
                      Item(string: "Do homework", completion: false, increacedImportance: true),
                      Item(string: "Wash moms car", completion: true, increacedImportance: false),
                      Item(string: "Call sister", completion: true, increacedImportance: false)
                     ]
    
    
    var sortedUpDown = false
    
    func addItem(string: String, completion: Bool = false, increacedImportance: Bool = false) {
        arrayItems.append(Item(string: string, completion: completion, increacedImportance: increacedImportance))
    }
    
    func removeItem(at index: Int) {
        arrayItems.remove(at: index)
    }
    
    func sortItem() {
        if sortedUpDown {
            arrayItems.sort(by: { $0.string > $1.string })
        } else {
            arrayItems.sort(by:{ $1.string > $0.string })
        }
    }
    
    func changeCompletion(index: Int) -> Bool {
        arrayItems[index].completion.toggle()
        return arrayItems[index].completion
    }
    
    func changeIncreasedImportance(index: Int) -> Bool {
        arrayItems[index].increacedImportance.toggle()
        return arrayItems[index].increacedImportance
    }
    
    func updateItem(at index: Int, with string: String) {
        arrayItems[index].string = string
    }
    

    
    
    
}
