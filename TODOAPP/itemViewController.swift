//
//  itemViewController.swift
//  TODOAPP
//
//  Created by gian on 2023/10/17.
//

import UIKit


protocol AddItemDelegate {
    func addItem(item:TODOitem)
}
protocol EditItemDelegate {
    func editItem(newItem : TODOitem,itemIndex:Int)
}

class itemViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var isChecked: UISwitch!
    
    var addItemDelegate: AddItemDelegate?
    var editItemDelegate : EditItemDelegate?
    var itemToEdit : TODOitem?
    var itemIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.isEnabled = false
        if itemToEdit != nil{
            doneButton.isEnabled = true
            self.titleInput.text!=itemToEdit!.title
            self.isChecked.isOn = itemToEdit!.isCheaked
        }
    }
    
    @IBAction func cancle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        if itemToEdit == nil{
            self.addItemDelegate?.addItem(item: TODOitem(title: titleInput.text!, isCheaked: isChecked.isOn))
        } else{
            self.editItemDelegate?.editItem(newItem: TODOitem(title: titleInput.text!, isCheaked: isChecked.isOn),itemIndex: self.itemIndex)
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}


extension itemViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range,in : oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
}
