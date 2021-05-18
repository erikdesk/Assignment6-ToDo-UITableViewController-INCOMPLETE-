import UIKit

class PriorityToDoTableViewController: UITableViewController, PriorityToDoCellDelegate {

    let priorityCategories = ["★★★", "★★☆", "★☆☆", "☆☆☆"]
    var toDos = [[ToDo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        toDos = splitToDoIntoPrioritySections(ToDo.loadSampleToDos())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func splitToDoIntoPrioritySections(_ toDos: [ToDo]) -> [[ToDo]] {
        
        var toDosSplitByPriority = [[ToDo]]()
        
        toDosSplitByPriority.append([ToDo]())
        toDosSplitByPriority.append([ToDo]())
        toDosSplitByPriority.append([ToDo]())
        toDosSplitByPriority.append([ToDo]())
        
        for i in 0..<toDos.count {
            if toDos[i].priority == 3 {
                toDosSplitByPriority[3].append(toDos[i])
            } else if toDos[i].priority == 2 {
                toDosSplitByPriority[2].append(toDos[i])
            } else if toDos[i].priority == 1 {
                toDosSplitByPriority[1].append(toDos[i])
            } else {
                toDosSplitByPriority[0].append(toDos[i])
            }
        }
        
        return toDosSplitByPriority
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return priorityCategories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return priorityCategories[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityToDoCellIdentifier", for: indexPath) as! PriorityToDoCell
        
        cell.delegate = self
        
        let toDo = toDos[indexPath.section][indexPath.row]
        cell.titleLabel.text = toDo.title
        cell.dueDateLabel.text = ToDo.dueDateFormatter.string(from: toDo.dueDate)
        cell.priorityLabel.text = priorityCategories[toDo.priority]
        cell.isCompleteButton.isSelected = toDo.isComplete
        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print(toDos[indexPath.section][indexPath.row].id)
            toDos[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath, destinationIndexPath)
        
//        let movedObject = self.headlines[sourceIndexPath.row]
        
//        headlines.remove(at: sourceIndexPath.row)
//        headlines.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func checkmarkTapped(sender: PriorityToDoCell) {
        
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailController = ToDoDetailTableViewController(coder: coder)
        detailController?.toDo = toDos[indexPath.section][indexPath.row]
        return detailController
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        if let toDo = sourceViewController.toDo {
//            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
//                toDos[indexOfExistingToDo] = toDo
//                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
//            } else {
            print(toDo)
            let newIndexPath = IndexPath(row: toDos[toDo.priority].count, section: toDo.priority)
                toDos[toDo.priority].append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
        }
    }
    
//    @IBAction func startEditing(_ sender: UIBarButtonItem) {
//        isEditing = !isEditing
//    }
    
    @IBAction func deleteSelectedRows(_ sender: UIBarButtonItem) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            // 1
//            var items = [String]()
            for indexPath in selectedRows  {
//                toDos[indexPath.section][]
                toDos[indexPath.section].remove(at: indexPath.row)
            }
//            // 2
//            for item in items {
//                if let index = numbers.index(of: item) {
//                    numbers.remove(at: index)
//                }
//            }
//            // 3
            print(selectedRows)
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    @IBAction func checkmarkTapped(_ sender: UIButton) {
//        if let indexPath = tableView.indexPath(for: sender) {
//            var toDo = toDos[indexPath.row]
//            toDo.isComplete.toggle()
//            toDos[indexPath.row] = toDo
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
