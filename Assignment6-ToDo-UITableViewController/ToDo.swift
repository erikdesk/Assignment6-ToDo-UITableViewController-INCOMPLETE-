import Foundation

struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var priority: Int
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, priority: 1, dueDate: Date().addingTimeInterval(0.5 * 24 * 60 * 60), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: true, priority: 2, dueDate: Date().addingTimeInterval(-10 * 24 * 60 * 60), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, priority: 3, dueDate: Date().addingTimeInterval(8 * 24 * 60 * 60), notes: "Notes 3")
        let todo4 = ToDo(title: "ToDo Four", isComplete: false, priority: 0, dueDate: Date().addingTimeInterval(20 * 24 * 60 * 60), notes: "Notes 4")
        let todo5 = ToDo(title: "ToDo Five", isComplete: true, priority: 2, dueDate: Date().addingTimeInterval(45 * 24 * 60 * 60), notes: "Notes 5")
        let todo6 = ToDo(title: "ToDo Six", isComplete: true, priority: 2, dueDate: Date().addingTimeInterval(0.5 * 24 * 60 * 60), notes: "Notes 6")
        let todo7 = ToDo(title: "ToDo Seven", isComplete: false, priority: 3, dueDate: Date().addingTimeInterval(3 * 24 * 60 * 60), notes: "Notes 7")
        let todo8 = ToDo(title: "ToDo Eight", isComplete: false, priority: 3, dueDate: Date().addingTimeInterval(0.75 * 24 * 60 * 60), notes: "Notes 8")
        
        return [todo1, todo2, todo3, todo4, todo5, todo6, todo7, todo8]
    }
    
    static let dueDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "(EEE) MMM d"
        return formatter
    }()
}
