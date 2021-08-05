//
//  MapViewSelectorController.m
//  carteira virtual
//
//  Created by Daniel Queiroz on 05/08/21.
//


import UIKit
import MapKit

class MapViewSelectorController : UIViewController, MKMapViewDelegate{
    
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
        
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: 37.50125068712187, longitude: -122.32789791415763)
        mapView.addAnnotation(london)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        //mapView.setRegion(viewRegion, animated: true)
        
        print("\(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        //37.50125068712187, -122.32789791415763
    }
}
