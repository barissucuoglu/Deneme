//
//  ViewController.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 23.02.2024.
//

//import UIKit
//import SnapKit
//
//class ViewController: UIViewController {
//    
//    let tableView = UITableView()
//    let sections = ["All", "iOS Developer", "Flutter Developer", "Design Team"]
//    var filteredSections: [String] = []
//    var selectedItem = "All"
//    
//    var passengers: [Passenger] = [
//        Passenger(name: "Selçuk", surname: "İleri", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "selcukileri@gmail.com"),
//        Passenger(name: "Taha", surname: "Özmen", team: "iOS Developer", age: "23", hometown: "Nevşehir", mail: "tahaozmen@gmail.com"),
//        Passenger(name: "Beyza", surname: "Düz", team: "Design Team", age: "25", hometown: "Adana", mail: "beyzaduz@gmail.com"),
//        Passenger(name: "Furkan", surname: "Ahmet", team: "Flutter Developer", age: "25", hometown: "Iğdır", mail: "furkanahmet@gmail.com"),
//        Passenger(name: "Mehmet Furkan", surname: "Metin", team: "Flutter Developer", age: "23", hometown: "Nevşehir", mail: "furkanmetin@gmail.com"),
//        Passenger(name: "Zeynep", surname: "Öztürk", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "zeynepozturk@gmail.com"),
//        Passenger(name: "Barış", surname: "Sucuoğlu", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "barissucuoglu@gmail.com"),
//        Passenger(name: "Kamil", surname: "Koç", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "kamilkoc@gmail.com"),
//    ]
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewController()
//        configureTableView()
////        setupScopeButtons()
//    }
//    
//    func configureViewController() {
//        view.backgroundColor = .systemBackground
//        title = "Passangers"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
////    func setupScopeButtons() {
////        let segmentedControl = UISegmentedControl(items: sections)
////        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
////        segmentedControl.selectedSegmentIndex = 0
////        navigationItem.titleView = segmentedControl
////    }
//    
//    
//    private func configureTableView() {
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        tableView.rowHeight = 80
//        tableView.frame = view.bounds
//        tableView.register(PassengerCell.self, forCellReuseIdentifier: PassengerCell.reuseID)
//    }
//    
////    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
////        let selectedIndex = sender.selectedSegmentIndex
////        let selectedItem = sections[selectedIndex]
////        print(selectedItem)
////        if selectedItem == "All" {
////            filteredSections = sections
////        } else {
////            filteredSections = [selectedItem]
////        }
////        DispatchQueue.main.async { self.tableView.reloadData() }
////    }
//}
//
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionTitle = sections[section]
//        return passengers.filter { $0.team == sectionTitle}.count
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PassengerCell.reuseID, for: indexPath) as! PassengerCell
//        
//        let sectionTitle = sections[indexPath.section]
//        let passengerInSection = passengers.filter { $0.team == sectionTitle}
//        let passenger = passengerInSection[indexPath.row]
//        cell.set(passenger: passenger)
//        return cell
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let passengerInSection = passengers.filter { $0.team == sections[indexPath.section]}
//        let passenger = passengerInSection[indexPath.row]
//        let destVC = PassengerDetailsVC(passenger: passenger)
//        navigationController?.pushViewController(destVC, animated: true)
//    }
//    
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else { return }
//        let sectionTitle = sections[indexPath.section]
//        let passengerInSection = passengers.filter { $0.team == sectionTitle }
//        let passenger = passengerInSection[indexPath.row]
//        if let index = passengers.firstIndex(where: { $0 === passenger }) {
//            passengers.remove(at: index)
//        }
//        tableView.deleteRows(at: [indexPath], with: .left)
//    }
//    
//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
//            let sectionTitle = self.sections[indexPath.section]
//            let passengerInSection = self.passengers.filter { $0.team == sectionTitle}
//            let passenger = passengerInSection[indexPath.row]
//            let alert = UIAlertController(title: "Edit Passenger", message: "Edit \(passenger.name)'s information", preferredStyle: .alert)
//            
//            alert.addTextField { textField in
//                textField.placeholder = "Edit Name"
//                textField.text = passenger.name
//                
//            }
//            
//            alert.addTextField { textField in
//                textField.placeholder = "Edit Surname"
//                textField.text = passenger.surname
//            }
//            
//            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//                guard let newName = alert.textFields?[0].text,
//                      let newSurname = alert.textFields?[1].text else { return }
//                
//                let editedPassanger = passenger
//                editedPassanger.name = newName
//                editedPassanger.surname = newSurname
////                self.handleEdit(at: indexPath, with: passenger)
//                DispatchQueue.main.async { self.tableView.reloadData() }
//            }
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(saveAction)
//            alert.addAction(cancelAction)
//            
//            self.present(alert, animated: true)
//            completion(true)
//        }
//        editAction.backgroundColor = .blue
//        return UISwipeActionsConfiguration(actions: [editAction])
//    }
//    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//           return true
//       }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch sections[section] {
//        case sections[1]:
//            "iOS Team"
//        case sections[2]:
//            "Flutter Team"
//        case sections[3]:
//            "Design Team"
//        default:
//            nil
//        }
//    }
//    
//}
//
////#Preview(body: {
////    ViewController()
////})







//
//  ViewController.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 23.02.2024.
//

//import UIKit
//import SnapKit
//
//class ViewController: UIViewController {
//    
//    let tableView = UITableView()
//    let sections = ["All", "iOS Developer", "Flutter Developer", "Design Team"]
//    var filteredSections: [String] = []
//    var selectedItem = "All"
//    var filteredArr = [Passenger]()
//    var isFiltering = false
//    var passengers: [Passenger] = [
//        Passenger(name: "Selçuk", surname: "İleri", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "selcukileri@gmail.com"),
//        Passenger(name: "Taha", surname: "Özmen", team: "iOS Developer", age: "23", hometown: "Nevşehir", mail: "tahaozmen@gmail.com"),
//        Passenger(name: "Beyza", surname: "Düz", team: "Design Team", age: "25", hometown: "Adana", mail: "beyzaduz@gmail.com"),
//        Passenger(name: "Furkan", surname: "Ahmet", team: "Flutter Developer", age: "25", hometown: "Iğdır", mail: "furkanahmet@gmail.com"),
//        Passenger(name: "Mehmet Furkan", surname: "Metin", team: "Flutter Developer", age: "23", hometown: "Nevşehir", mail: "furkanmetin@gmail.com"),
//        Passenger(name: "Zeynep", surname: "Öztürk", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "zeynepozturk@gmail.com"),
//        Passenger(name: "Barış", surname: "Sucuoğlu", team: "iOS Developer", age: "25", hometown: "Istanbul", mail: "barissucuoglu@gmail.com"),
//        Passenger(name: "Kamil", surname: "Koç", team: "Design Team", age: "23", hometown: "Kastamonu", mail: "kamilkoc@gmail.com"),
//    ]
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewController()
//        configureTableView()
//        setupScopeButtons()
//    }
//    
//    func configureViewController() {
//        view.backgroundColor = .systemBackground
//        title = "Passangers"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
//    func setupScopeButtons() {
//        let segmentedControl = UISegmentedControl(items: sections)
//        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
//        segmentedControl.selectedSegmentIndex = 0
//        navigationItem.titleView = segmentedControl
//    }
//    
//    
//    private func configureTableView() {
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = 80
//        tableView.frame = view.bounds
//        tableView.register(PassengerCell.self, forCellReuseIdentifier: PassengerCell.reuseID)
//    }
//    
//    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
//        let selectedIndex = sender.selectedSegmentIndex
//        selectedItem = sections[selectedIndex]
//        print(selectedItem)
//        
//        switch selectedItem {
//        case "All":
//            filteredArr = passengers
//            self.isFiltering = false
//           
//            
//        case "iOS Developer":
//            filteredArr = passengers.filter({$0.team == "iOS Developer"})
//            self.isFiltering = true
//
//        default:
//            "nil"
//        }
//       DispatchQueue.main.async {self.tableView.reloadData()}
//    }
//}
//
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print("selected item is : \(selectedItem)")
//        if selectedItem == "All" {
//            return sections.count
//        } else {
//            return 1
//        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredArr.count
//        } else {
//            return passengers.count
//        }
//        
//        
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PassengerCell.reuseID, for: indexPath) as! PassengerCell
//        if self.isFiltering {
//            //        let sectionTitle = sections[indexPath.section]
//            //        let passengerInSection = passengers.filter { $0.team == sectionTitle}
//            //        let passenger = passengerInSection[indexPath.row]
//            //        cell.set(passenger: passenger)
//
//            let item = filteredArr[indexPath.row]
//            cell.set(passenger: item)
//            return cell
//        } else {
//            let item = passengers[indexPath.row]
//            cell.set(passenger: item)
//            return cell
//        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let passengerInSection = passengers.filter { $0.team == sections[indexPath.section]}
//        if isFiltering {
//            let passenger = filteredArr[indexPath.row]
//            let destVC = PassengerDetailsVC(passenger: passenger)
//            navigationController?.pushViewController(destVC, animated: true)
//        } else {
//            let passenger = passengers[indexPath.row]
//            let destVC = PassengerDetailsVC(passenger: passenger)
//            navigationController?.pushViewController(destVC, animated: true)
//        }
//        
//       
//       
//    }
//    
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else { return }
//        let sectionTitle = sections[indexPath.section]
//        let passengerInSection = passengers.filter { $0.team == sectionTitle }
//        let passenger = passengerInSection[indexPath.row]
//        if let index = passengers.firstIndex(where: {$0 == passenger}) {
//            passengers.remove(at: index)
//        }
//        tableView.deleteRows(at: [indexPath], with: .left)
//    }
//    
//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
//            let sectionTitle = self.sections[indexPath.section]
//            let passengerInSection = self.passengers.filter { $0.team == sectionTitle}
//            let passenger = passengerInSection[indexPath.row]
//            let alert = UIAlertController(title: "Edit Passenger", message: "Edit \(passenger.name)'s information", preferredStyle: .alert)
//            
//            alert.addTextField { textField in
//                textField.placeholder = "Edit Name"
//                textField.text = passenger.name
//                
//            }
//            
//            alert.addTextField { textField in
//                textField.placeholder = "Edit Surname"
//                textField.text = passenger.surname
//            }
//            
//            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//                guard let newName = alert.textFields?[0].text,
//                      let newSurname = alert.textFields?[1].text else { return }
//                
//                var editedPassanger = passenger
//                editedPassanger.name = newName
//                editedPassanger.surname = newSurname
////                self.handleEdit(at: indexPath, with: passenger)
//                DispatchQueue.main.async { self.tableView.reloadData() }
//            }
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(saveAction)
//            alert.addAction(cancelAction)
//            
//            self.present(alert, animated: true)
//            completion(true)
//        }
//        editAction.backgroundColor = .blue
//        return UISwipeActionsConfiguration(actions: [editAction])
//    }
//    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//           return true
//       }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch sections[section] {
//        case sections[1]:
//            "iOS Team"
//        case sections[2]:
//            "Flutter Team"
//        case sections[3]:
//            "Design Team"
//        default:
//            nil
//        }
//    }
//    
//}

//#Preview(body: {
//    ViewController()
//})
