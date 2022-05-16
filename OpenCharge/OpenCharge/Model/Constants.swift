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
    static let dummyLocation = (latitude: 52.521, longitude: 13.415)
    static let scale = 0.015
    static let dummyLocationList: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                                              CLLocationCoordinate2D(latitude: dummyLocation.latitude, longitude: dummyLocation.longitude)]
    
}
