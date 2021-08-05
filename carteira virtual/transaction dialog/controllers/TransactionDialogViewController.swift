//
//  TransactionDialogViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 11/07/21.
//

import UIKit
import MapKit

protocol PopUpDelegate {
    func handleAction(name: String, value: Double, date: Date, lat:Double?, long:Double?)
}

class TransactionDialogViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {

    static let identifier = "TransactionDialogViewController"
    
    var delegate: PopUpDelegate?
    //MARK:- outlets for the view controller
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateField: UIDatePicker!
    @IBOutlet var transactionType: UISegmentedControl!
    
    
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var currentLocation: CLLocationCoordinate2D?
    
    //MARK:- lifecyle methods for the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        dialogBoxView.layer.cornerRadius = 6.0
        
        locationManager = CLLocationManager()
        mapView.mapType = .standard
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    //MARK:- outlet functions for the viewController
    @IBAction func addButtonPressed(_ sender: Any) {
        
        if nameField.text != nil
            && valueField.text != nil{
        
            let name = nameField.text!
            var value = Double(valueField.text!)!
            let date = dateField.date
            
            if(transactionType.selectedSegmentIndex == 1){
                value *= -1
            }
            
            let lat = currentLocation?.latitude
            let long = currentLocation?.longitude
            self.delegate?.handleAction(name: name, value: value, date: date, lat: lat, long: long)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- functions for the viewController
    static func showPopup(parentVC: UIViewController){
        if let popupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDialogViewController") as? TransactionDialogViewController {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? PopUpDelegate
            parentVC.present(popupViewController, animated: true)
        }
      }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        if textField.keyboardType == .decimalPad {
            if(currentText.contains(".")){
                if string == "."{
                    return false
                }
            }
            
            if CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: string)) {
                return currentText.count < 9
            }
            
        }
        return false
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(viewRegion, animated: true)
        
        currentLocation = userLocation.coordinate
        //print("my location is \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        //37.50125068712187, -122.32789791415763
    }
}
