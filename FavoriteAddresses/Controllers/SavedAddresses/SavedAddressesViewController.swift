//
//  SavedAddressesViewController.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

class SavedAddressesViewController: BaseViewController {
    var tableView: UITableView!
    var dataSource: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddButton()

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = self.view.backgroundColor
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = 0
        self.view.addSubview(tableView)
        
        constrain(self.view, tableView) { (view, table) in
            table.edges == inset(view.edges, 0, 0, 0, 0)
        }
        
        dataSource = AddressManager.shared.addresses
    }
    
    override var screenTitle: String? {
        return R.string.localizable.savedAddresses()
    }
    
    func addAddress() {
        let addressMapController = AddressesMapViewController()
        self.navigationController?.pushViewController(addressMapController, animated: true)
    }
}

//MARK: - Конфигурация интерфейса и компонентов контроллера
extension SavedAddressesViewController {
    func setupAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAddressPressed(_:)))
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    @objc
    private func addAddressPressed(_ sender: UIBarButtonItem) {
        self.addAddress()
    }
    
    func emptyView() -> UIView {
        let result = UIView()
        result.backgroundColor = UIColor.clear
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.text = R.string.localizable.noAddressesAdded()
        result.addSubview(titleLabel)
        
        let addButton = UIButton.confirmGreenButton()
        addButton.setTitle(R.string.localizable.addAddress(), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        result.addSubview(addButton)
        
        constrain(result, titleLabel, addButton) { (view, title, button) in
            title.top == view.top + 16
            title.left == view.left + 16
            title.right == view.right - 16
            
            button.top == title.bottom + 16
            button.left == title.left
            button.right == title.right
        }
        
        return result
    }
    
    @objc
    private func addButtonPressed(_ sender: UIButton) {
        self.addAddress()
    }
}

// MARK: - UITableViewDataSource
extension SavedAddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AddressCell")
        if let label = dataSource[indexPath.row].label, !label.isTrimmedEmpty {
            cell.textLabel?.text = label
            cell.detailTextLabel?.text = dataSource[indexPath.row].preview
        } else {
            cell.textLabel?.text = dataSource[indexPath.row].preview
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SavedAddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if dataSource.isEmpty {
            return self.emptyView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135
    }
}
