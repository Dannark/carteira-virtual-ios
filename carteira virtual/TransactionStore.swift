//
//  TransactionModel.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//

import UIKit

class TransactionStore{
    
    var itemList = [TransactionItem]()
    
    init(){
        for _ in 0..<3{
            createItem()
        }
    }
    
    @discardableResult func createItem() -> TransactionItem{
        let newItem = TransactionItem(random: true)
        
        //itemList.append(newItem)
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
    
}
