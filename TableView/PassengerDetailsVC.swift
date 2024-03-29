//
//  PassengerDetailsVC.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 26.02.2024.
//

import UIKit
import SnapKit

class PassengerDetailsVC: UIViewController {
    
    var passenger: Passenger!
    let fullnameLabel = UILabel()
    let ageLabel = UILabel()
    let teamLabel = UILabel()
    let hometownLabel = UILabel()
    let mailLabel = UILabel()
    
    init(passenger: Passenger) {
        super.init(nibName: nil, bundle: nil)
        self.passenger = passenger
        title = "\(passenger.name) \(passenger.surname)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    private func layoutUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(fullnameLabel, ageLabel, teamLabel, hometownLabel, mailLabel)
        
        fullnameLabel.text = "\(passenger.name) \(passenger.surname)"
        ageLabel.text = "\(passenger.age)"
        teamLabel.text = "\(passenger.team)"
        hometownLabel.text = "\(passenger.hometown)"
        mailLabel.text = "\(passenger.mail)"
        
        fullnameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(fullnameLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        teamLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        hometownLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(hometownLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}
