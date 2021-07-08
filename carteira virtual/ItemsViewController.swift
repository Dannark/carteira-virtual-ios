//
//  ItemViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//
	
import UIKit

class ItemsViewController: UITableViewController{
    var transactionStore: TransactionStore = TransactionStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = transactionStore.createItem()
        
        if let index = transactionStore.itemList.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionStore.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        
        let item = transactionStore.itemList[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "R$\(item.valueInReais)"
        
        return cell
    }
}
