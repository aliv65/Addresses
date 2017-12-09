//
//  StartViewController.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

class StartViewController: BaseViewController {
    var savedAddressesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        savedAddressesButton.isEnabled = AddressManager.shared.hasAddresses
    }
}

// MARK: - Конфигурация интерфейса и копмонентов контроллера
extension StartViewController {
    func setupUI() {
        let newAddressButton = UIButton(type: .system)
        newAddressButton.setTitle(R.string.localizable.addAddress(), for: .normal)
        newAddressButton.setTitleColor(UIColor.blue, for: .normal)
        newAddressButton.addTarget(self, action: #selector(addAddressPressed(_:)), for: .touchUpInside)
        self.view.addSubview(newAddressButton)
        
        savedAddressesButton = UIButton(type: .system)
        savedAddressesButton.setTitle(R.string.localizable.showSavedAddresses(), for: .normal)
        savedAddressesButton.setTitleColor(UIColor.blue, for: .normal)
        savedAddressesButton.setTitleColor(UIColor.blue.withAlphaComponent(0.6), for: .disabled)
        savedAddressesButton.addTarget(self, action: #selector(showSavedAddresses(_:)), for: .touchUpInside)
        self.view.addSubview(savedAddressesButton)
        
        constrain(self.view, newAddressButton, savedAddressesButton) { (view, new, saved) in
            new.left == view.left + 16
            new.right == view.right - 16
            new.height == 44
            new.centerY == view.centerY - 32
            
            saved.left == new.left
            saved.right == new.right
            saved.height == new.height
            saved.centerY == view.centerY + 32
        }
    }
    
    @objc
    private func addAddressPressed(_ sender: UIButton) {
        let newAddressController = AddressesMapViewController()
        self.navigationController?.pushViewController(newAddressController, animated: true)
    }
    
    @objc
    private func showSavedAddresses(_ sender: UIButton) {
        let savedAddressesController = SavedAddressesViewController()
        self.navigationController?.pushViewController(savedAddressesController, animated: true)
    }
}
