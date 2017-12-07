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
    }
    
    override var screenTitle: String? {
        return "SavedAddresses".localized
    }
}

// MARK: - UITableViewDataSource
extension SavedAddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "AddressCell")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SavedAddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
