//
//  MapViewController.swift
//  carteira virtual
//
//  Created by Daniel Queiroz on 05/08/21.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate{
    
    var transactionStore: TransactionStore?// = TransactionStore()
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
        
    override func loadView() {
        mapView = MKMapView()
        locationManager = CLLocationManager()
        
        view = mapView
        mapView.mapType = .standard
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapaViewController carregado na View")
        mapView.pointOfInterestFilter = .excludingAll
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        guard let items = transactionStore?.itemList else {
            return
        }
        
        for item in items{
            print(item)
            
            guard let lat = item.lat,
                  let long = item.long else {
                return
            }
            
            let london = MKPointAnnotation()
            london.title = item.name
            london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            mapView.addAnnotation(london)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(viewRegion, animated: true)
        
    }
}
