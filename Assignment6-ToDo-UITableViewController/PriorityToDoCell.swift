import UIKit

protocol PriorityToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: PriorityToDoCell)
}

class PriorityToDoCell: UITableViewCell {
    
    weak var delegate: PriorityToDoCellDelegate?

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
