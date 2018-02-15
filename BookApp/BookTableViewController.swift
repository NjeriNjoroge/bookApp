import UIKit

class BookTableViewController: UITableViewController {
        
    var bookNames = ["The Abotionists Daughter", "The Secret Life of Bees", "I Do Not Come To You By Chance", "GirlBoss", "I am Malala", "The Autobiography of Malcom X", "Outliers", "I'm Too Pretty To Be Broke", "Wangari Maathai - Unbowed"]
    
    var author = ["Elisabeth Hyde", "Sue Monk Kid", "Adaobi Nwaubani", "Sophia Amoruso", "Malala Yousafzai", "Alex Haley", "Malcom Gladwell", "Joan Thatiah", "Wangari Maathai"]
    
    var bookPic = ["abortionist", "bees", "chance", "girlboss", "malala", "malcomx", "outliers", "pretty", "wangari"]
    
    var bookIsVisited = Array(repeating: false, count:9)
   

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! bookTableViewCell

        // Configure the cell...
        cell.titleLabel.text = bookNames[indexPath.row]
        cell.bookImage.image = UIImage(named: bookPic[indexPath.row])
        cell.authorLabel.text = author[indexPath.row]
        
        cell.starView.isHidden = self.bookIsVisited[indexPath.row] ? false : true

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //to make the grey select not linger for long
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //swipe to the left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            
            self.bookPic.remove(at: indexPath.row)
            self.bookNames.remove(at: indexPath.row)
            self.author.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        //share action
        let shareAction = UIContextualAction(style: .normal, title: "Share") {
            (action, sourceView, completionHandler) in
            let shareText = "Just checking in at " + self.bookNames[indexPath.row]
            
            let activityController : UIActivityViewController
            
            if let imageToShare = UIImage(named: self.bookPic[indexPath.row]) {
                
                             activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            } else {
                
                activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            }

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(named: "ic_delete_white")
     
        shareAction.backgroundColor = UIColor(red: 65.0/255.0, green: 131.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "ic_share_white")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeActions
    }
    
    //swipe to the right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //checkAction
        let checkAction = UIContextualAction(style: .normal, title: "Check") {
            (action, sourceView, completionHandler) in
            
         let cell = tableView.cellForRow(at: indexPath) as! bookTableViewCell
            
            self.bookIsVisited[indexPath.row] = (self.bookIsVisited[indexPath.row]) ? false : true
            cell.starView.isHidden = self.bookIsVisited[indexPath.row] ? false : true
            
            completionHandler(true)
            
        }
        checkAction.image = self.bookIsVisited[indexPath.row] ? UIImage(named: "ic_undo_white") : UIImage(named: "ic_check_white")
        checkAction.backgroundColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        
        return UISwipeActionsConfiguration(actions: [checkAction])
    }
}

