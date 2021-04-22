//
//  TaskDetailViewController.swift
//  Task
//
//  Created by David Boyd on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    //MARK: - Properties
    var task: Task?

    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = taskNameLabel.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else {return}
        
        let date = taskDueDatePicker.date
        
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: name, notes: notes, dueDate: date)
        } else {
            TaskController.sharedInstance.createTaskWith(name: name, notes: notes, dueDate: date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        
    }
    
    //MARK: - Extensions
    func updateView() {
        guard let task = task else {return}
        taskNameLabel.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
}//End of class
