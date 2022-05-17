//
//  Constants.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import UIKit
import MapKit

enum Constants {
    static let location = (latitude: 52.526, longitude: 13.415)
    static let scale = 0.035
    static let dummyLocationList: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 44.00908, longitude: 10.590733),
        CLLocationCoordinate2D(latitude: 44.011346, longitude: 10.589534),
        CLLocationCoordinate2D(latitude: 44.06501, longitude: 10.441389),
        CLLocationCoordinate2D(latitude: 44.492796, longitude: 11.249772),
        CLLocationCoordinate2D(latitude: 44.493959, longitude: 11.300902),
    ]
    static let distance = 5
    static let distanceunit = "km"
    
}
