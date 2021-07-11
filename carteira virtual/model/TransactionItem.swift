//
//  TransactionItem.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 07/07/21.
//

import Foundation

class TransactionItem: Equatable{
    
    var name: String
    var valueInReais: Int
    var id: String?
    let dateCreated: Date
    
    init(name: String, valueInReais: Int, dateCreated: Date) {
        self.name = name
        self.valueInReais = valueInReais
        self.id = UUID().uuidString.components(separatedBy: "-").first!
        self.dateCreated = dateCreated
    }
    
    convenience init(random: Bool = false) {
        if random {
            let transactionNames = ["Mercado Livre", "Supermercado Campeão", "Uber"]
            
            let randomTransaction = transactionNames.randomElement()!
            
            let randomName = "\(randomTransaction)"
            let randomValue = Int.random(in: -50..<100)
            
            self.init(name: randomName, valueInReais: randomValue, dateCreated: Date())
        } else {
            self.init(name: "", valueInReais: 0, dateCreated: Date())
        }
    }
    
    static func == (lhs: TransactionItem, rhs: TransactionItem) -> Bool {
        return lhs.name == rhs.name
            && lhs.id == rhs.id
            && lhs.valueInReais == rhs.valueInReais
            && lhs.dateCreated == rhs.dateCreated
    }
    
    func dayAndMonthFormat() -> String {
        if dateCreated == nil{
            return "-"
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        //formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        //formatter.dateFormat = "dd-MM-yyyy HH:mm:ss Z"
        //let datetime = formatter.date(from: "13-03-2020 13:37:00 +0100")
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        return formatter.string(from: dateCreated)
    }
    
}
