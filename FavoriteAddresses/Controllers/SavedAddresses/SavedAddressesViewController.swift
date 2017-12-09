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

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
