//
//  DetailChargeView.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 17.05.2022.
//

import UIKit
protocol IDetailChargeView: class {
    func setupUI(addressName: String, charger: Int)
    func chargePointDetect(chargePoint: Int) -> String
}

class DetailChargeView: UIView, IDetailChargeView {
    
    private lazy var  visualView:  UIVisualEffectView = {
        let visualView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualView.layer.cornerRadius = 20
        visualView.clipsToBounds = true
        visualView.alpha = 0.8
        visualView.translatesAutoresizingMaskIntoConstraints = false
        return visualView
    }()
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Information"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// This function shows the address and charge point numbers
    /// - Parameters:
    ///   - addressName: location address
    ///   - charger: charger number
    func setupUI(addressName: String, charger: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let addressHeaderAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            let addressDetailAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
            
            let address = NSMutableAttributedString(string: "Address:\n", attributes: addressHeaderAttribute)
            let addressDetail = NSMutableAttributedString(string: addressName, attributes: addressDetailAttribute)
            address.append(addressDetail)
            
            let chargePointHeader = NSMutableAttributedString(string: "\n\nCharger Point:\n", attributes: addressHeaderAttribute)
            address.append(chargePointHeader)
            let chargePointDetail = NSMutableAttributedString(string:"Station has " + (self.chargePointDetect(chargePoint: charger)), attributes: addressDetailAttribute)
            address.append(chargePointDetail)
            
            self.detailLabel.attributedText = address
        }
    }
    
    /// This function returns a  string after processed charger points
    /// - Parameter chargePoint: charger point number
    /// - Returns: It will be using inside of the label to give better information.
    internal func chargePointDetect(chargePoint: Int) -> String {
        switch chargePoint {
        case -1:
            return "unknown charger point."
        case 0:
            return "any charger point."
        case 1:
            return "1 charger point."
        default:
            return "\(chargePoint) charger points."
        }
    }
}

extension DetailChargeView {
    /// This functions adds some views as subview.
    private func setViews() {
        addSubview(visualView)
        addSubview(informationLabel)
        addSubview(detailLabel)
        setupLayout()
    }
    /// This function creates layout
    func setupLayout() {
        visualView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        visualView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        visualView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visualView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        informationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        informationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        detailLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
}

