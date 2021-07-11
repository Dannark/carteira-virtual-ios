//
//  ItemViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//
	
import UIKit

class ItemsViewController: UITableViewController, PopUpDelegate{
    var transactionStore: TransactionStore = TransactionStore()
    
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        updateTotalValue()
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
//        let newItem = transactionStore.createItem()
//
//        if let index = transactionStore.itemList.firstIndex(of: newItem) {
//            let indexPath = IndexPath(row: index, section: 0)
//
//            tableView.insertRows(at: [indexPath], with: .automatic)
//        }
//
//        updateTotalValue()
        
        TransactionDialogViewController.showPopup(parentVC: self)
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            
            sender.setTitle("Editar", for: .normal)
            
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: true)
        }
    }
    
    func updateTotalValue(){
        var currentTotal = 0
        for item in transactionStore.itemList{
            currentTotal += item.valueInReais
        }
        totalLabel.text = "\(currentTotal),00"
        
        if currentTotal < 0{
            totalLabel?.textColor = UIColor.red
        }
        else{
            totalLabel?.textColor = UIColor.black
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionStore.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionItemCell", for: indexPath) as! TransactionItemCell
        
        let item = transactionStore.itemList[indexPath.row]
        
        cell.nameLabel?.text = item.name
        cell.dataLabel?.text = "\(item.dayAndMonthFormat())"
        cell.valueLabel?.text = "R$ \(item.valueInReais),00"
        
        if item.valueInReais < 0{
            cell.valueLabel?.textColor = UIColor.red
        }
        else{
            cell.valueLabel?.textColor = UIColor.black
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = transactionStore.itemList[indexPath.row]

            // remover o item da store
            transactionStore.removeItem(item)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalValue()
        }
    }
    
    func handleAction(action: Bool) {
    //opening a link to the app store if the user clickes on the go to app store button
        if (action) {
            print("button clicked")
          }
       }
    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        transactionStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
//    }
}
