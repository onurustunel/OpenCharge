//
//  ChargeDetailViewController.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 17.05.2022.
//

import UIKit
import MapKit

final class ChargeDetailViewController: UIViewController {
    
    /// Selected Charger Station
    lazy var chargerDetail: ChargerInfo? = nil {
        didSet {
            guard let chargerDetail = chargerDetail else { return }
            setupUI(chargerDetail: chargerDetail)
        }
    }
    /// Custom view to show address and charger point number
    lazy var detailView = DetailChargeView()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    init(chargerDetail: ChargerInfo?) {
        super.init(nibName: nil, bundle: nil)
        self.chargerDetail = chargerDetail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()      
    }
    
    /// Basic MapKit setup and add annotation to chosen point
    /// - Parameter location: latitude and longitude
    private func setupMapView(location: CLLocationCoordinate2D) {
        // Setup MapView
        let span = MKCoordinateSpan(latitudeDelta: Constants.detailScale, longitudeDelta: Constants.detailScale)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        // Setup Annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = chargerDetail?.AddressInfo?.Title ?? ""
        self.mapView.addAnnotation(annotation)
    }
    
    /// Setup UI with Selected Charger Station Details
    /// - Parameter chargerDetail: Selected Charger Station
    private func setupUI(chargerDetail: ChargerInfo) {
        title = chargerDetail.AddressInfo?.Title
        var address: String {
            return "\(chargerDetail.AddressInfo?.AddressLine1 ?? "No Address...")" + " \(chargerDetail.AddressInfo?.AddressLine2 ?? "")"
        }
        setupMapView(location: .init(latitude: (chargerDetail.AddressInfo?.Latitude ?? 0.0), longitude: (chargerDetail.AddressInfo?.Longitude ?? 0.0) ))
        detailView.setupUI(addressName: address, charger: chargerDetail.NumberOfPoints ?? -1)
    }

}

extension ChargeDetailViewController {
    /// This functions adds some views as subview.
    fileprivate func setupView() {
        view.addSubview(mapView)
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    /// This function creates layout
    fileprivate func setupLayout() {
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        detailView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
    }
}
