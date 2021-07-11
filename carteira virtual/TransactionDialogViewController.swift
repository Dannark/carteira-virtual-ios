//
//  TransactionDialogViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 11/07/21.
//

import UIKit

protocol PopUpDelegate {
    func handleAction(name: String, value: Int, date: Date)
}

class TransactionDialogViewController: UIViewController {

    static let identifier = "TransactionDialogViewController"
    
    var delegate: PopUpDelegate?
    //MARK:- outlets for the view controller
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateField: UIDatePicker!
    
    //MARK:- lifecyle methods for the view controller
    override func viewDidLoad() {
         super.viewDidLoad()
        //adding an overlay to the view to give focus to the dialog box
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        dialogBoxView.layer.cornerRadius = 6.0
        //dialogBoxView.layer.borderWidth = 1.2
        //dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        
        //customizing the go to app store button
//        gotoStoreButton.backgroundColor = UIColor(named: "primaryBackground")?.withAlphaComponent(0.85)
//        gotoStoreButton.setTitleColor(UIColor.white, for: .normal)
//        gotoStoreButton.layer.borderWidth = 1.2
//        gotoStoreButton.layer.cornerRadius = 4.0
//        gotoStoreButton.layer.borderColor = UIColor(named: "primaryBackground")?.cgColor
    }
    //MARK:- outlet functions for the viewController
    @IBAction func addButtonPressed(_ sender: Any) {
        
        if nameField.text != nil
            && valueField.text != nil{
        
            let name = nameField.text!
            let value = Int(valueField.text!)!
            let date = dateField.date
            
            self.delegate?.handleAction(name: name, value: value, date: date)
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK:- functions for the viewController
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDialogViewController") as? TransactionDialogViewController {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        //setting the delegate of the dialog box to the parent viewController
        popupViewController.delegate = parentVC as? PopUpDelegate
        //presenting the pop up viewController from the parent viewController
        parentVC.present(popupViewController, animated: true)
        }
      }
    

}
