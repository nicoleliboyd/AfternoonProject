//
//  TaskTableViewCell.swift
//  Task
//
//  Created by David Boyd on 4/21/21.
//

import UIKit

//MARK: - Protocol

protocol TaskCompletionDelegate: class {
    func taskCellButtonTapped(for cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

//MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
//MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
//MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(for: self)
        }
    }
    
//MARK: - Functions
    
    func updateViews() {
        guard let task = task else {return}
        taskNameLabel.text = task.name
        
        if task.isComplete {
            completionButton.setBackgroundImage(#imageLiteral(resourceName: "CompleteIcon"), for: .normal)
        } else {
            completionButton.setBackgroundImage(#imageLiteral(resourceName: "IncompleteIcon"), for: .normal)
        }
    }
    
}//End of class
