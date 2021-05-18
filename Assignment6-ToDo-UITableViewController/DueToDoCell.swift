import UIKit

protocol DueToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: DueToDoCell)
}

import UIKit

class DueToDoCell: UITableViewCell {
    
    weak var delegate: DueToDoCellDelegate?
    
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
