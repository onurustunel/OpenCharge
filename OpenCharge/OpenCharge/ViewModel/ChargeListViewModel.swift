//
//  ChargeListViewModel.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 17.05.2022.
//

import Foundation

protocol IChargeListViewModel {
    func fetchItems()
    func changeLoading()
    var chargeListData: [ChargerInfo] { get set }
    var chargeListService: IOpenChargeNetworkService { get }
    var delegate: ChargeListOutput? { get }
    func setDelegate(outPut: ChargeListOutput)    
}

final class ChargeListViewModel: IChargeListViewModel {
    var delegate: ChargeListOutput?
    func setDelegate(outPut: ChargeListOutput) {
        delegate = outPut
    }
    
    var chargeListData: [ChargerInfo] = []
    private var isLoading: Bool = false
    let chargeListService: IOpenChargeNetworkService
    
    init() {
        chargeListService = OpenChargeNetworkService()
    }
    
    func fetchItems() {
        changeLoading()
        chargeListService.fetchAllData { [weak self] (result) in
            self?.changeLoading()
            self?.chargeListData = result ?? []
            self?.delegate?.saveData(values: self?.chargeListData ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        delegate?.changeLoading(isLoading: isLoading)
    }
}
