//
//  ItemViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//
	
import UIKit

class ItemsViewController: UITableViewController{
    var transactionStore: TransactionStore = TransactionStore()
    
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        updateTotalValue()
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = transactionStore.createItem()
        
        if let index = transactionStore.itemList.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        updateTotalValue()
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionStore.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let item = transactionStore.itemList[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "R$ \(item.valueInReais),00"
        
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
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        transactionStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
