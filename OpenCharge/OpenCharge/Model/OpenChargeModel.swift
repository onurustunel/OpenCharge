//
//  OpenChargeModel.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import Foundation

/// This is the base model which is used in app very frequently
struct ChargerInfo: Decodable  {
    var AddressInfo: AddressInfo?
    var NumberOfPoints: Int?
}

/// Address information model of charge station
struct AddressInfo: Decodable {
    var ID: Int?
    var Title: String?
    var AddressLine1: String?
    var AddressLine2: String?
    var Latitude: Double?
    var Longitude: Double?
}
