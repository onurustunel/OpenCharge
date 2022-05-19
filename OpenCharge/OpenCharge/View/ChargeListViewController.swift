//
//  ChargeListViewController.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import UIKit
import MapKit

protocol ChargeListOutput {
    func changeLoading(isLoading: Bool)
    func saveData(values: [ChargerInfo])
}

final class ChargeListViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    private let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    private var data = [ChargerInfo]() {
        didSet {
            setAnnotationPoints(data)
        }
    }
    
    lazy var viewModel: IChargeListViewModel = ChargeListViewModel()
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchItems()
        timer = Timer.scheduledTimer(timeInterval: Constants.refreshRequestDuration, target: self, selector: #selector(refreshRequest), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupMapView()
        viewModel.setDelegate(outPut: self)
    }
    
    /// This function sends request every Constants.refreshRequestDuration time
    @objc fileprivate func refreshRequest() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        viewModel.fetchItems()
    }
    
    /// Add Annotation on desired latitude and longitude
    /// - Parameter locationList: list of charger station locations. [ChargerInfo] includes this data.
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
    
    /// Setup MapView basically with desired location datas and focus on the region
    fileprivate func setupMapView() {
        let location = CLLocationCoordinate2D(latitude: Constants.location.latitude, longitude: Constants.location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: Constants.scale, longitudeDelta: Constants.scale)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    /// Here we invalidate timer
    /// - Parameter animated: animated
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
}

extension ChargeListViewController: ChargeListOutput {
    /// Shows indicator when sending a request and hides when data is returned
    /// - Parameter isLoading: request status
    func changeLoading(isLoading: Bool) {
        isLoading ? self.indicator.startAnimating() : indicator.stopAnimating()
    }
    
    /// Gives us the data after sending the request
    /// - Parameter values: Data which is returned after sending request
    func saveData(values: [ChargerInfo]) {
        data = values
    }
}

extension ChargeListViewController {
    /// setup navigation bar
    fileprivate func setupNavigationBar() {
        title = "Charger List"
    }
    /// This functions adds some views as subview.
    fileprivate func setupView() {
        view.addSubview(mapView)
        view.addSubview(indicator)
        setupLayout()
    }
    /// This function creates layout
    fileprivate func setupLayout() {
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        indicator.center = view.center
    }
}


extension ChargeListViewController: MKMapViewDelegate {
    /// This function works when tapped an annotation
    /// - Parameters:
    ///   - mapView: mapView
    ///   - view: MKAnnotationView
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if let customAnnotation = view.annotation as? CustomAnnotation {
            /// Here we filter selected location with ID...
            let selectedStation = data.filter { (element) -> Bool in
                element.AddressInfo?.ID == customAnnotation.ID
            }
            let controller = ChargeDetailViewController(chargerDetail: selectedStation.first)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

/// This class extends MKPointAnnotation and it has ID property to understand which annotation is clicked.
class CustomAnnotation: MKPointAnnotation {
    var ID = -1
}
