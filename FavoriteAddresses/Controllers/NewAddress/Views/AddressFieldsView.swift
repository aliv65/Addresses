//
//  AddressFieldsView.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

enum AddressFields {
    case name
    case area
    case apartment
    case block
    case street
    case building
    case floor
    case apartmentNo
    case phone
    case special
    
    var placeholder: String {
        switch self {
        case .name:
            return "NamePlaceholder".localized
        case .area:
            return "AreaPlaceholder".localized
        case .apartment:
            return "ApartmentPlaceholder".localized
        case .block:
            return "BlockPlaceholder".localized
        case .street:
            return "StreetPlaceholder".localized
        case .building:
            return "BuildingPlaceholder".localized
        case .floor:
            return "FloorPlaceholder".localized
        case .apartmentNo:
            return "ApartmentNoPlaceholder".localized
        case .phone:
            return "PhonePlaceholder".localized
        case .special:
            return "SpecialPlaceholder".localized
        }
    }
    
    var title: String? {
        switch self {
        case .name:
            return "NameTitle".localized
        default:
            return nil
        }
    }
    
    static var fields: [AddressFields] {
        return [.name,
                .area,
                .apartment,
                .block,
                .street,
                .building,
                .floor,
                .apartmentNo,
                .phone,
                .special]
    }
}

protocol AddressFieldsDelegate: class {
    func save(address: Address)
    func showError(message: String)
}

class AddressFieldsView: UIView {
    var dataSource: [AddressFields]
    var savedDataFields: [AddressFields: String]
    var address: AddressResponseModel = AddressResponseModel()
    
    var tableView: UITableView!
    var saveButton: UIButton!
    
    weak var delegate: AddressFieldsDelegate?
    
    init() {
        self.dataSource = AddressFields.fields
        savedDataFields = Dictionary<AddressFields, String>()
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func save() {
        guard validateFields() else {
            self.delegate?.showError(message: "MissedRequiredFields".localized)
            return
        }
//        self.delegate?.save(address: self.address)
    }
    
    func validateFields() -> Bool {
        for (field, value) in savedDataFields {
            if field != .name && field != .special && value.isTrimmedEmpty {
                return false
            }
        }
        return !savedDataFields.isEmpty
    }
}

// MARK: - Конфигурация интерфейса
extension AddressFieldsView {
    func setupUI() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = self.backgroundColor
        tableView.tableHeaderView = UIView()
        self.addSubview(tableView)
        
        constrain(self, tableView) { (view, table) in
            table.edges == inset(view.edges, 0, 0, 0, 0)
        }
    }
}


// MARK: - UITableViewDataSource
extension AddressFieldsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressFieldTableViewCell(field: dataSource[indexPath.row])
        cell.delegate = self
        cell.isLast = indexPath.row == dataSource.count - 1
        cell.isScrollable = dataSource[indexPath.row] == .special
        switch dataSource[indexPath.row] {
        case .area:
            cell.setFieldValue(address.area)
        case .block:
            cell.setFieldValue(address.block)
        case .street:
            cell.setFieldValue(address.street)
        default:
            break
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension AddressFieldsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == dataSource.count - 1 ? 127.0 : 47.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 92.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.tableFooterColor
        
        let savedButton = UIButton.confirmGreenButton()
        savedButton.setTitle("Save".localized, for: .normal)
        savedButton.addTarget(self, action: #selector(saveAddressPressed(_:)), for: .touchUpInside)
        view.addSubview(savedButton)
        
        constrain(view, savedButton) { (view, button) in
            button.bottom == view.bottom
            button.left == view.left
            button.right == view.right
        }
        
        return view
    }
    
    @objc
    private func saveAddressPressed(_ sender: UIButton) {
        self.save()
    }
}

// MARK: - AddressFieldTableViewCellDelegate
extension AddressFieldsView : AddressFieldTableViewCellDelegate {
    func update(field: AddressFields, with value: String) {
        savedDataFields[field] = value
    }
}
