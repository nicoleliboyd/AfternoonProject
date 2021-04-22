//
//  TaskListTableViewController.swift
//  Task
//
//  Created by David Boyd on 4/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskController.sharedInstance.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    //MARK: - Properties
    var task: Task?
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}

        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
        cell.task = task
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.delete(task: taskToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as?TaskDetailViewController else {return}
            
            let taskToSend = TaskController.sharedInstance.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }
}//End of class

//MARK: - Extension
extension TaskListTableViewController: TaskCompletionDelegate {

func taskCellButtonTapped(for cell: TaskTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else {return}
    let task = TaskController.sharedInstance.tasks[indexPath.row]
    TaskController.sharedInstance.toggleIsComplete(task: task)
    cell.updateViews()
    }
}
