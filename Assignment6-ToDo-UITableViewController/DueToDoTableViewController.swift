import UIKit

class DueToDoTableViewController: UITableViewController {
    
    let dueCategories = ["Past Due", "Due in a Day", "Due in a Week", "Due in a Month", "Due beyond a Month"]
    let priorityCategories = ["★★★", "★★☆", "★☆☆", "☆☆☆"]
    var toDos = [[ToDo]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        toDos = splitToDoIntoDueSections(ToDo.loadSampleToDos())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func splitToDoIntoDueSections(_ toDos: [ToDo]) -> [[ToDo]] {
        
        var toDosSplitByDue = [[ToDo]]()
        
        toDosSplitByDue.append([ToDo]())
        toDosSplitByDue.append([ToDo]())
        toDosSplitByDue.append([ToDo]())
        toDosSplitByDue.append([ToDo]())
        toDosSplitByDue.append([ToDo]())
        
        let now = Date()
        
        for i in 0..<toDos.count {
            if toDos[i].dueDate < now.addingTimeInterval(0) {
                toDosSplitByDue[0].append(toDos[i])
            } else if toDos[i].dueDate >= now.addingTimeInterval(0) && toDos[i].dueDate < now.addingTimeInterval(1 * 60 * 60 * 24)  {
                toDosSplitByDue[1].append(toDos[i])
            } else if toDos[i].dueDate >= now.addingTimeInterval(1 * 60 * 60 * 24) &&  toDos[i].dueDate < now.addingTimeInterval(7 * 60 * 60 * 24) {
                toDosSplitByDue[2].append(toDos[i])
            } else if toDos[i].dueDate >= now.addingTimeInterval(7 * 60 * 60 * 24) && toDos[i].dueDate < now.addingTimeInterval(30 * 60 * 60 * 24) {
                toDosSplitByDue[3].append(toDos[i])
            } else {
                toDosSplitByDue[4].append(toDos[i])
            }
        }
        
        return toDosSplitByDue
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dueCategories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dueCategories[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DueToDoCellIdentifier", for: indexPath) as! DueToDoCell
        
//        cell.delegate = self
        
        let toDo = toDos[indexPath.section][indexPath.row]
        cell.titleLabel.text = toDo.title
        cell.dueDateLabel.text = ToDo.dueDateFormatter.string(from: toDo.dueDate)
        cell.priorityLabel.text = priorityCategories[toDo.priority]
        cell.isCompleteButton.isSelected = toDo.isComplete
        cell.showsReorderControl = true

        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
