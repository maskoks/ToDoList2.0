//
//  CustomCell.swift
//  toDoList2.0Tests
//
//  Created by Жеребцов Данил on 19.05.2021.
//

import UIKit
// делегат, который имплементирует контроллер
protocol CustomCellDelegate {
    func changeImportance(cell: CustomCell)
    func deleteTask(cell: CustomCell)
}


// класс кастномной ячейки
class CustomCell: UITableViewCell {
   
    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var importanceButton: UIButton!
    @IBOutlet weak var labelText: UILabel!
    
    // actions кнопок, логика которых будут реализованы в классе, который имплементирует протокол
    @IBAction func importanceAction(_ sender: Any) {
        delegate?.changeImportance(cell: self)
    }
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteTask(cell: self)
    }
    
}
