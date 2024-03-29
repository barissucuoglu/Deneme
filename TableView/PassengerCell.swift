//
//  PassengerCell.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 23.02.2024.
//

import UIKit
import SnapKit

class PassengerCell: UITableViewCell {
    
    static let reuseID = "PassengerCell"
    
    let passengerImageView = UIImageView()
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(passenger: Passenger) {
        label.text = "\(passenger.name) \(passenger.surname)"
        passengerImageView.image = UIImage(systemName: "person.fill")
    }
    
    
    private func configure() {
        addSubviews(passengerImageView, label)
        let padding: CGFloat = 12
        
        accessoryType = .disclosureIndicator
        passengerImageView.tintColor = .lightGray
        
        passengerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(padding)
            make.width.height.equalTo(60)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(passengerImageView.snp.centerY)
            make.leading.equalTo(passengerImageView.snp.trailing).offset(2 * padding)
            make.trailing.equalToSuperview().inset(-padding)
            make.height.equalTo(40)
        }
    }
}
