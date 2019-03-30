//
//  ToDoViewController.swift
//  ToobyDoo
//
//  Created by student5 on 3/23/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    // MARK: - UI objects
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Indicators
    
    var todo : ToDo?
    var isPickerHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            dueDatePicker.date = todo.dueDate
            noteTextView.text = todo.notes
        } else {
            dueDatePicker.date =
                Date().addingTimeInterval(24*60*60)
        } // end if-let-else
        
        updateSaveButtonState()
        dueDatePicker.date = Date().addingTimeInterval(24*60*60) // starting the due date 24 hours in the future
        updateDueDateLabel(date: dueDatePicker.date)
        
    } // end viewDidLoad
    
    
    // MARK: - Custom Methods
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    } // end updateSaveButtonState
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    } // end updateDueDateLabel
    
    
    
    // MARK: - IBActions
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
        
    } // end textEditingChanged
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    } // end returnPressed
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePicker.date)
    } // datePickerChanged
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    } // end numberOfSections
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    } // end numberOfRowsInSection
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,0]: // Due Date Cell
            return isPickerHidden ? normalCellHeight :
            largeCellHeight
            
        case [2,0]: // Notes Cell
            return largeCellHeight
            
        default: return normalCellHeight
        }
        
    } // end heightForRowAt indexPath
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isPickerHidden = !isPickerHidden
            
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        } // end switch
    } // end didSelectRowAt indexPath
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let dueDate = dueDatePicker.date
        let notes = noteTextView.text
        
        todo = ToDo(title: title, isComplete: false, dueDate: dueDate, notes: notes)
        
    } // end prepare for segue
    
    
} // end ToDoViewController
