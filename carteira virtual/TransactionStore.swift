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
        for _ in 0..<10{
            createItem()
        }
    }
    
    @discardableResult func createItem() -> TransactionItem{
        let newItem = TransactionItem(random: true)
        
        itemList.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: TransactionItem) {
        if let index = itemList.firstIndex(of: item) {
            itemList.remove(at: index)
        }
    }
    
}

//
////
////  ItemStore.swift
////  Lista de Compras
////
////  Created by Lucas Oliveira on 24/06/21.
////
//
//import UIKit
//
//class ItemStore {
//
//    var allItems = [Item]()
//
//    @discardableResult func createItem() -> Item {
//        let newItem = Item(random: true)
//
//        allItems.append(newItem)
//
//        return newItem
//    }
//
//    func removeItem(_ item: Item) {
//        if let index = allItems.firstIndex(of: item) {
//            allItems.remove(at: index)
//        }
//    }
//
//    func moveItem(from fromIndex: Int, to toIndex: Int) {
//        if fromIndex == toIndex {
//            return
//        }
//
//        let movedItem = allItems[fromIndex]
//
//        allItems.remove(at: fromIndex)
//
//        allItems.insert(movedItem, at: toIndex)
//    }
//}
