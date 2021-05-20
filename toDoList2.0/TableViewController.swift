//
//  TableViewController.swift
//  toDoList2.0
//
//  Created by Жеребцов Данил on 17.05.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    // создаем экземпляр класса Model для доступа к методам класса и к хранимым в классе данным итд.
    let model = Model()
    // алерт для реализации функции добавления задания
    var alert = UIAlertController()
    // изображения для выбора важности события
    let increasedImportanceImage = UIImage(systemName: "star.fill")
    let defaultImportanceImage = UIImage(systemName: "star")
    // аутлет кнопки сортировки для упарелния ей в функции соритровки
    @IBOutlet weak var sortButton: UIBarButtonItem!
    // загружаем вид, соритруем имеющиеся задания
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .gray
        title = "Tasks"
        model.sortItem()
        tableView.reloadData()
    }

    // две функции для отрисовки таблицы и ее наполнения
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return model.arrayItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let currentItem = model.arrayItems[indexPath.row]
        cell.delegate = self
        cell.labelText.text = currentItem.string
        
        if currentItem.increacedImportance {
            cell.importanceButton.setImage(increasedImportanceImage, for: .normal)
        } else {
            cell.importanceButton.setImage(defaultImportanceImage, for: .normal)
        }
        
        cell.accessoryType = currentItem.completion ? .checkmark : .none
        return cell
    }
    // функция, которая меняет "выполненость" задачи, обращаясь к этмоу свойству через модель
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if model.changeCompletion(index: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
    }

    //две функции, реализующие добавление задания
    @objc func alertTextFieldDidChange(_ sender: UITextField) {

            guard let senderText = sender.text, alert.actions.indices.contains(1) else { return }

            let action = alert.actions[1]
            action.isEnabled = senderText.count > 0
        }
    
    @IBAction func addTaskButtonAction(_ sender: Any) {

        alert = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Put your task here"
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (createAlert) in
            // add new task
            
            guard let unwrTextFieldValue = self.alert.textFields?[0].text else {
                return
            }
            
            self.model.addItem(string: unwrTextFieldValue, completion: false, increacedImportance: false)
            self.model.sortItem()
            self.tableView.reloadData()
            
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(cancelAlertAction)
        alert.addAction(createAlertAction)
        present(alert, animated: true, completion: nil)
        createAlertAction.isEnabled = false
    }
    // функция реализующая сортировку, которпя так же обращается к свойству модели и изменяет свойство айтема
    @IBAction func sortButtonAction(_ sender: Any) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        
        model.sortedUpDown.toggle()
        
        sortButton.image = model.sortedUpDown ? arrowDown : arrowUp
        model.sortItem()
        tableView.reloadData()
    }

}
// имплементация протокола, через которую реализованы кнопки на ячейке
extension TableViewController: CustomCellDelegate {
    
    
    func deleteTask(cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else {
            return
        }
        model.removeItem(at: unwrIndexPath.row )
        tableView.reloadData()
    }
    
    func changeImportance(cell: CustomCell) {
        let indexPath = tableView.indexPath(for: cell)
        guard let unwrIndexPath = indexPath else { return }
        
        if model.changeIncreasedImportance(index: unwrIndexPath.row) {
            cell.importanceButton.setImage(increasedImportanceImage, for: .normal)
        } else {
            cell.importanceButton.setImage(defaultImportanceImage, for: .normal)
        }
        tableView.reloadData()
    }
}
