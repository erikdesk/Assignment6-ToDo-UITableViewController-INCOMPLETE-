import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    var toDo: ToDo?
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 1, section: 1)
    let datePickerIndexPath = IndexPath(row: 2, section: 1)
    let notesIndexPath = IndexPath(row: 1, section: 0)
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var priorityOneButton: UIButton!
    @IBOutlet weak var priorityTwoButton: UIButton!
    @IBOutlet weak var priorityThreeButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDo = toDo {
            navigationItem.title = "Edit To Do Item"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            dueDatePickerView.date = toDo.dueDate
            notesTextView.text = toDo.notes
            
            if toDo.priority == 0 {
                priorityOneButton.isSelected = true
                priorityTwoButton.isSelected = true
                priorityThreeButton.isSelected = true
            } else if toDo.priority == 1 {
                priorityOneButton.isSelected = true
                priorityTwoButton.isSelected = true
                priorityThreeButton.isSelected = false
            } else {
                priorityOneButton.isSelected = true
                priorityTwoButton.isSelected = false
                priorityThreeButton.isSelected = false
            }
            
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(0)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        var priority: Int
        if priorityThreeButton.isSelected {
            priority = 0
        } else if priorityTwoButton.isSelected {
            priority = 1
        } else {
            priority = 2
        }
        
        if toDo == nil {
            toDo = ToDo(title: title, isComplete: isComplete, priority: priority, dueDate: dueDate, notes: notes)
        } else {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
            toDo?.priority = priority
        }
        
    }
    
    func updateSaveButtonState() {
        let hasTitleValue = titleTextField.text?.isEmpty == false
        let hasPriorityValue = priorityOneButton.isSelected == true
        let shouldEnableSaveButton = hasTitleValue && hasPriorityValue
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    @IBAction func priorityOneButtonTapped(_ sender: UIButton) {
        priorityOneButton.isSelected = true
        priorityTwoButton.isSelected = false
        priorityThreeButton.isSelected = false
        updateSaveButtonState()
    }
    
    @IBAction func priorityTwoButtonTapped(_ sender: UIButton) {
        priorityOneButton.isSelected = true
        priorityTwoButton.isSelected = true
        priorityThreeButton.isSelected = false
        updateSaveButtonState()
    }
    
    @IBAction func priorityThreeButtonTapped(_ sender: UIButton) {
        priorityOneButton.isSelected = true
        priorityTwoButton.isSelected = true
        priorityThreeButton.isSelected = true
        updateSaveButtonState()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
}
