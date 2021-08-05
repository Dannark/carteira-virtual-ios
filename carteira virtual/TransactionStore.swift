//
//  TransactionModel.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//

import UIKit

class TransactionStore{
    
    var itemList = [TransactionItem]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([TransactionItem].self, from: data)
            itemList = items
        } catch {
            print("Error ao ler Itens salvos \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    func createItemRandom(){
        let newItem = TransactionItem(random: true)
        
        //itemList.append(newItem)
        itemList.insert(newItem, at: 0)
        
    }
    
    @discardableResult func createItem(name: String, valueInReais: Double, dateCreated: Date) -> TransactionItem{
        let newItem = TransactionItem(name: name, valueInReais: valueInReais, dateCreated: dateCreated)
        
        itemList.insert(newItem, at: 0)
        
        return newItem
    }
    
    func removeItem(_ item: TransactionItem) {
        if let index = itemList.firstIndex(of: item) {
            itemList.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = itemList[fromIndex]
        
        itemList.remove(at: fromIndex)
        
        itemList.insert(movedItem, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool{
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(itemList)
            
            try data.write(to: itemArchiveURL, options: [.atomic])
            print("todos os items foram salvos")
            return true
        } catch {
            print("Erro ao encoder itemList \(error)")
            return false
        }
    }
}
