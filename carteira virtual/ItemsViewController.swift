//
//  ItemViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//
	
import UIKit

class ItemsViewController: UITableViewController, PopUpDelegate{
    var transactionStore: TransactionStore = TransactionStore()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @IBOutlet var totalLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        updateTotalValue()
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        TransactionDialogViewController.showPopup(parentVC: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionStore.itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionItemCell", for: indexPath) as! TransactionItemCell
        
        let item = transactionStore.itemList[indexPath.row]
        
        cell.nameLabel?.text = item.name
        cell.dataLabel?.text = "\(item.dayAndMonthFormat())"
//        cell.valueLabel?.text = "R$ \(item.valueInReais),00"
        cell.valueLabel?.text = numberFormatter.string(from: NSNumber(value: item.valueInReais))
        
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
    
    func handleAction(name: String, value: Double, date: Date) {
        createNewRow(name: name, value: value, date: date)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        transactionStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    private func createNewRow(name: String, value: Double, date: Date){
        let newItem = transactionStore.createItem(name: name, valueInReais: value, dateCreated: date)

        if let index = transactionStore.itemList.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)

            tableView.insertRows(at: [indexPath], with: .automatic)
        }

        updateTotalValue()
    }
    
    private func updateTotalValue(){
        var currentTotal = 0.0
        for item in transactionStore.itemList{
            currentTotal += item.valueInReais
        }
        totalLabel.text = numberFormatter.string(from: NSNumber(value: currentTotal))
        
        if currentTotal < 0{
            totalLabel?.textColor = UIColor.red
        }
        else{
            totalLabel?.textColor = UIColor.black
        }
    }
}
