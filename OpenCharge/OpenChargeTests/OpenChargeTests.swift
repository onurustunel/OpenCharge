//
//  OpenChargeTests.swift
//  OpenChargeTests
//
//  Created by Onur Ustunel on 16.05.2022.
//

import XCTest
@testable import OpenCharge

class OpenChargeTests: XCTestCase {
    
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let charger: [ChargerInfo] = try! JSONDecoder().decode([ChargerInfo].self, from: json)
        XCTAssertEqual(charger[0].AddressInfo?.ID, 87785)
        XCTAssertEqual(charger[0].AddressInfo?.Title, "Karl-Liebknecht-Straße")
        XCTAssertEqual(charger[0].AddressInfo?.AddressLine1, "Karl-Liebknecht-Straße 29")
        XCTAssertEqual(charger[0].AddressInfo?.AddressLine2, "Mitte")
        XCTAssertEqual(charger[0].AddressInfo?.Latitude, 52.524438232115585)
        XCTAssertEqual(charger[0].AddressInfo?.Longitude, 13.412951344982966)
        XCTAssertEqual(charger[0].NumberOfPoints, 2)
    }
    
    func testPresentChargerDetail() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try! Data(contentsOf: url)
        let charger: [ChargerInfo] = try! JSONDecoder().decode([ChargerInfo].self, from: json)
        let controller = ChargeDetailViewController(chargerDetail: charger[0])
        XCTAssertEqual(controller.chargerDetail?.NumberOfPoints, 2)
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.ID, 87785)
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.Title, "Karl-Liebknecht-Straße")
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.AddressLine1, "Karl-Liebknecht-Straße 29")
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.AddressLine2, "Mitte")
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.Latitude, 52.524438232115585)
        XCTAssertEqual(controller.chargerDetail?.AddressInfo?.Longitude, 13.412951344982966)
    }
    
    func testChargerPointDetect() {
        let detailView = DetailChargeView()
        var result = detailView.chargePointDetect(chargePoint: -1)
        XCTAssertEqual(result, "unknown charger point.")
        result = detailView.chargePointDetect(chargePoint: 0)
        XCTAssertEqual(result, "any charger point.")
        result = detailView.chargePointDetect(chargePoint: 1)
        XCTAssertEqual(result, "1 charger point.")
        result = detailView.chargePointDetect(chargePoint: 5)
        XCTAssertEqual(result, "5 charger points.")
    }
  
}
