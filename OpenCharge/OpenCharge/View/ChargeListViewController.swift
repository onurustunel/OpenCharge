//
//  ChargeListViewController.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import UIKit
import MapKit

class ChargeListViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private var data = [ChargerInfo]() {
        didSet {
            setAnnotationPoints(data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupMapView()
              
    }
    
    fileprivate func setAnnotationPoints(_ locationList: [ChargerInfo]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for index in locationList {
                let annotation = CustomAnnotation()
                let place = CLLocationCoordinate2D(latitude: index.AddressInfo?.Latitude ?? 0.0,
                                                   longitude: index.AddressInfo?.Longitude ?? 0.0)
                annotation.coordinate = place
                annotation.ID = index.AddressInfo?.ID ?? -1
                annotation.title = index.AddressInfo?.Title ?? ""
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func setupMapView() {
        let location = CLLocationCoordinate2D(latitude: Constants.location.latitude, longitude: Constants.location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: Constants.scale, longitudeDelta: Constants.scale)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}

extension ChargeListViewController {
    fileprivate func setupNavigationBar() {
        title = "Charger List"
    }
    fileprivate func setupView() {
        view.addSubview(mapView)
        setupLayout()
    }
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
                                        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        mapView.topAnchor.constraint(equalTo: view.topAnchor),
                                        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        )
    }
}


extension ChargeListViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print("didSelectAnnotationTapped")
        if let customAnnotation = view.annotation as? CustomAnnotation {
            let selectedStation = data.filter { (element) -> Bool in
                element.AddressInfo?.ID == customAnnotation.ID
            }
            print(selectedStation)
        }
    }
    
}

class CustomAnnotation: MKPointAnnotation {
    var ID = -1
}
