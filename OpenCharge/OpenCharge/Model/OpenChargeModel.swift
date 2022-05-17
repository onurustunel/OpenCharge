//
//  OpenChargeModel.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import Foundation

struct ChargerInfo: Decodable  {
    var AddressInfo: AddressInfo?
    var NumberOfPoints: Int?
}

struct AddressInfo: Decodable {
    var ID: Int?
    var Title: String?
    var AddressLine1: String?
    var AddressLine2: String?
    var Latitude: Double?
    var Longitude: Double?
}
