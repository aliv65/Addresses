//
//  AddressFieldTableViewCell.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

protocol AddressFieldTableViewCellDelegate: class {
    func update(field: AddressFields, with value: String)
}

class AddressFieldTableViewCell: UITableViewCell {
    static let reuseIdeentifier = String(describing: AddressFieldTableViewCell.self)
    
    var titleLabel: UILabel!
    var addressField: UITextView!
    var separator: UIView!
    
    weak var delegate: AddressFieldTableViewCellDelegate?
    
    var field: AddressFields?
    
    var value: String = String() {
        didSet {
            addressField.text = value
        }
    }
    
    var isScrollable: Bool = false {
        didSet {
            addressField.isScrollEnabled = isScrollable
        }
    }
    
    var isLast: Bool = false {
        didSet {
            separator.isHidden = isLast
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: AddressFieldTableViewCell.reuseIdeentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddressField(_ field: AddressFields) {
        self.field = field
        addressField.placeholder = field.placeholder
        titleLabel.text = field.title
    }
    
    func setFieldValue(_ value: String) {
        self.value = value
    }
}

// MARK: - Конфигурация интерфейса
extension AddressFieldTableViewCell {
    func setupUI() {
        addressField = UITextView()
        addressField.delegate = self
        addressField.font = UIFont.systemFont(ofSize: 15)
        addressField.placeholderColor = UIColor.black.withAlphaComponent(0.3)
        addressField.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(addressField)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(titleLabel)
        
        separator = UIView()
        separator.backgroundColor = UIColor.cellSeparatorColor
        contentView.addSubview(separator)
        
        constrain(contentView, addressField, titleLabel, separator) { (content, field, title, separator) in
            field.edges == inset(content.edges, 8, 10, 0, 16)
            
            title.top == content.top + 3
            title.left == content.left + 16
            
            separator.bottom == field.bottom
            separator.left == content.left + 16
            separator.right == content.right
            separator.height == 1
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddressFieldTableViewCell : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let field = field else {
            fatalError("Field is not set for AddressTableViewCell but required")
        }
        self.delegate?.update(field: field, with: textView.text)
    }
}
