//
//  TableViewController.swift
//  TODOAPP
//
//  Created by gian on 2023/10/17.
//

import UIKit

class TableViewController: UITableViewController {
    var items:[TODOitem] = [
        TODOitem(title: "homework", isCheaked: false),
        TODOitem(title: "work dog", isCheaked: true),
        TODOitem(title: "play football", isCheaked: true)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
   
        self.navigationController?.navigationBar.prefersLargeTitles = true
        loadItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOCell", for: indexPath) as! TableViewCell

        // Configure the cell...
        
        let item = items[indexPath.row]
        
        cell.title.text! = item.title
        
        if item.isCheaked {
            cell.status.text! = "✅"
            
        }else{
            cell.status.text! = "  "
        }
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "additem"{
            let addItemViewController = segue.destination as! itemViewController
            addItemViewController.addItemDelegate = self
        } else if segue.identifier == "edititem"{
            let editItemViewController = segue.destination as! itemViewController
            let cell = sender as! TableViewCell
            var isChecked : Bool
            if cell.status.text!=="✅"{
                isChecked = true
            }else{
                isChecked = false
            }
            let item = TODOitem(title: cell.title.text!, isCheaked: isChecked)
            editItemViewController.itemToEdit = item
            editItemViewController.itemIndex = tableView.indexPath(for: cell)!.row
            editItemViewController.editItemDelegate = self
        }
    

}

}
    extension TableViewController: AddItemDelegate{
        func addItem(item:TODOitem){
            self.items.append(item)
            self.tableView.reloadData()
        }
    }


extension TableViewController :EditItemDelegate{
    func editItem(newItem: TODOitem, itemIndex: Int) {
        self.items[itemIndex] = newItem
        self.tableView.reloadData()
    }
}

extension TableViewController {
    func dataFilePath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return path!.appendingPathComponent("TODOItems.json")
    }
    
    func saveAllItem(){
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: dataFilePath(),options: .atomic)
            
        }catch {
            print("Can not save: \(error.localizedDescription)")
        }
        
    }
    func loadItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            do {
                items = try JSONDecoder().decode([TODOitem].self, from: data)
            } catch  {
                print("Error decoding list:\(error.localizedDescription)")
            }
        }
    }
}
