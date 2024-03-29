//
//  ViewController.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 23.02.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let sections = ["All", "iOS Developer", "Flutter Developer", "Design Team"]
    var selectedItem = "All"
    var filteredArr = [Passenger]()
    var isFiltering = false
    var passengers: [Passenger] = [
        Passenger(name: "Selçuk", surname: "İleri", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "selcukileri@gmail.com"),
        Passenger(name: "Taha", surname: "Özmen", team: "iOS Developer", age: "23", hometown: "Nevşehir", mail: "tahaozmen@gmail.com"),
        Passenger(name: "Beyza", surname: "Düz", team: "Design Team", age: "25", hometown: "Adana", mail: "beyzaduz@gmail.com"),
        Passenger(name: "Furkan", surname: "Ahmet", team: "Flutter Developer", age: "25", hometown: "Iğdır", mail: "furkanahmet@gmail.com"),
        Passenger(name: "Mehmet Furkan", surname: "Metin", team: "Flutter Developer", age: "23", hometown: "Nevşehir", mail: "furkanmetin@gmail.com"),
        Passenger(name: "Zeynep", surname: "Öztürk", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "zeynepozturk@gmail.com"),
        Passenger(name: "Barış", surname: "Sucuoğlu", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "barissucuoglu@gmail.com"),
        Passenger(name: "Kamil", surname: "Koç", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "kamilkoc@gmail.com"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        setupScopeButtons()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Passangers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupScopeButtons() {
        let segmentedControl = UISegmentedControl(items: sections)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        tableView.register(PassengerCell.self, forCellReuseIdentifier: PassengerCell.reuseID)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        selectedItem = sections[selectedIndex]
        print(selectedItem)
        
        switch selectedItem {
        case "All":
            filteredArr = passengers
            self.isFiltering = false
        case "iOS Developer":
            filteredArr = passengers.filter{$0.team == "iOS Developer"}
            self.isFiltering = true
        case "Flutter Developer":
            filteredArr = passengers.filter{$0.team == "Flutter Developer"}
            self.isFiltering = true
        case "Design Team":
            filteredArr = passengers.filter{$0.team == "Design Team"}
            self.isFiltering = true
        default:
            print("Unexpected case")
        }
        DispatchQueue.main.async {self.tableView.reloadData()}
    }
    
    func handleEdit(at indexPath: IndexPath, with passenger: Passenger) {
        if isFiltering {
            let filteredPassenger = filteredArr[indexPath.row]
            if let index = passengers.firstIndex(where: { $0 == filteredPassenger }) {
                passengers[index] = passenger
            }
        } else {
            passengers[indexPath.row] = passenger
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("selected item is : \(selectedItem)")
        if selectedItem == "All" {
            return sections.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArr.count
        } else {
            let sectionTitle = sections[section]
            return passengers.filter {$0.team == sectionTitle }.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PassengerCell.reuseID, for: indexPath) as! PassengerCell
        var passenger: Passenger
        if self.isFiltering {
            passenger = filteredArr[indexPath.row]
        } else {
            let sectionTitle = sections[indexPath.section]
            let passengerInSection = passengers.filter { $0.team == sectionTitle}
            passenger = passengerInSection[indexPath.row]
        }
        cell.set(passenger: passenger)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var passenger: Passenger
        passenger = isFiltering ? filteredArr[indexPath.row] : passengers[indexPath.row]
        let destVC = PassengerDetailsVC(passenger: passenger)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        var passenger: Passenger
        if isFiltering {
            passenger = filteredArr[indexPath.row]
            if let index = filteredArr.firstIndex(where: {$0 == passenger}) {
                filteredArr.remove(at: index)
            }
        } else {
            let sectionTitle = sections[indexPath.section]
            let passengerInSection = passengers.filter { $0.team == sectionTitle }
            passenger = passengerInSection[indexPath.row]
        }
        if let index = passengers.firstIndex(where: {$0 == passenger}) {
            passengers.remove(at: index)
        }
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
            var passenger: Passenger
            if self.isFiltering {
                passenger = self.filteredArr[indexPath.row]
            } else {
                let sectionTitle = self.sections[indexPath.section]
                let passengerInSection = self.passengers.filter { $0.team == sectionTitle}
                passenger = passengerInSection[indexPath.row]
            }
            let alert = UIAlertController(title: "Edit Passenger", message: "Edit \(passenger.name)'s information", preferredStyle: .alert)
            _ = self.sections[indexPath.section]
            
            alert.addTextField { textField in
                textField.placeholder = "Edit Name"
                textField.text = passenger.name
            }
            
            alert.addTextField { textField in
                textField.placeholder = "Edit Surname"
                textField.text = passenger.surname
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let newName = alert.textFields?[0].text,
                      let newSurname = alert.textFields?[1].text else { return }
                
                passenger.name = newName
                passenger.surname = newSurname
                self.handleEdit(at: indexPath, with: passenger)
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
            completion(true)
        }
        editAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case sections[1]:
            "iOS Team"
        case sections[2]:
            "Flutter Team"
        case sections[3]:
            "Design Team"
        default:
            nil
        }
    }
    
}

//#Preview(body: {
//    ViewController()
//})
