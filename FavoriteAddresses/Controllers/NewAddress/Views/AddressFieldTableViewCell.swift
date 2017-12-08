//
//  AddressFieldTableViewCell.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography
import PhoneNumberKit
import SearchTextField

protocol AddressFieldTableViewCellDelegate: class {
    func update(field: AddressFields, with value: String)
}

class AddressFieldTableViewCell: UITableViewCell {
    static let reuseIdeentifier = String(describing: AddressFieldTableViewCell.self)
    
    var titleLabel: UILabel!
    var addressField: UITextField!
    var specialField: UITextView!
    var separator: UIView!
    
    weak var delegate: AddressFieldTableViewCellDelegate?
    
    var field: AddressFields
    
    var value: String? {
        didSet {
            if addressField != nil {
                addressField.text = value
            } else if specialField != nil {
                specialField.text = value
            }
        }
    }
    
    var isScrollable: Bool = false {
        didSet {
            if specialField != nil {
                specialField.isScrollEnabled = isScrollable
            }
        }
    }
    
    var isLast: Bool = false {
        didSet {
            separator.isHidden = isLast
        }
    }
    
    init(field: AddressFields) {
        self.field = field
        super.init(style: .default, reuseIdentifier: AddressFieldTableViewCell.reuseIdeentifier)
        
        setupUI()
        setAddressField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddressField() {
        if field == .special && specialField != nil {
            specialField.placeholder = field.placeholder
        } else if addressField != nil {
            addressField.placeholder = field.placeholder
        }
        if field == .phone {
            titleLabel.text = field.placeholder
            addressField.text = "+"
            addressField.keyboardType = .numberPad
        } else {
            titleLabel.text = field.title
        }
    }
    
    func setFieldValue(_ value: String?) {
        self.value = value
    }
}

// MARK: - Конфигурация интерфейса
extension AddressFieldTableViewCell {
    func setupUI() {
        if field == .special {
            specialField = UITextView()
            specialField.placeholderColor = UIColor.black.withAlphaComponent(0.3)
            specialField.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
            specialField.font = UIFont.systemFont(ofSize: 15)
            contentView.addSubview(specialField)
            
            constrain(self.contentView, specialField) { (content, field) in
                field.edges == inset(content.edges, 8, 10, 0, 16)
            }
        } else {
            if field == .phone {
                addressField = PhoneNumberTextField()
            } else if field == .area {
                addressField = SearchTextField(frame: CGRect.zero)
                (addressField as! SearchTextField).theme = .darkTheme()
                (addressField as! SearchTextField).theme.font = UIFont.systemFont(ofSize: 15)
                (addressField as! SearchTextField).theme.bgColor = UIColor.black.withAlphaComponent(0.7)
                (addressField as! SearchTextField).theme.borderColor = UIColor.black.withAlphaComponent(0.5)
                (addressField as! SearchTextField).theme.separatorColor = UIColor.black.withAlphaComponent(0.5)
                (addressField as! SearchTextField).theme.cellHeight = 50
                (addressField as! SearchTextField).maxNumberOfResults = 20
                (addressField as! SearchTextField).maxResultsListHeight = 200
                (addressField as! SearchTextField).comparisonOptions = [.caseInsensitive]
                (addressField as! SearchTextField).itemSelectionHandler = { filteredResults, itemPosition in
                    let item = filteredResults[itemPosition]
                    print("Item at position \(itemPosition): \(item.title)")
                    (self.addressField as! SearchTextField).text = item.title
                }
                (addressField as! SearchTextField).userStoppedTypingHandler = {
                    if let searchText = (self.addressField as! SearchTextField).text {
                        (self.addressField as! SearchTextField).showLoadingIndicator()
                        self.filterAreasInBackground(searchText) { results in
                            (self.addressField as! SearchTextField).filterItems(results)
                            (self.addressField as! SearchTextField).stopLoadingIndicator()
                        }
                    }
                    } as (() -> Void)
            } else {
                addressField = UITextField()
                addressField.delegate = self
                addressField.font = UIFont.systemFont(ofSize: 15)
            }
            contentView.addSubview(addressField)
            
            constrain(self.contentView, addressField) { (content, field) in
                field.edges == inset(content.edges, 8, 16, 0, 16)
            }
        }
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(titleLabel)
        
        separator = UIView()
        separator.backgroundColor = UIColor.cellSeparatorColor
        contentView.addSubview(separator)
        
        constrain(contentView, titleLabel, separator) { (content, title, separator) in
            title.top == content.top + 3
            title.left == content.left + 16
            
            separator.bottom == content.bottom
            separator.left == content.left + 16
            separator.right == content.right
            separator.height == 1
        }
    }
    
    func filterAreasInBackground(_ text: String, callback: @escaping ((_ results: [SearchTextFieldItem]) -> Void)) {
        APIProvider.shared.areas { (areas, error) in
            if error != nil {
                DispatchQueue.main.async {
                    callback([])
                }
                return
            }
            if let areas = areas {
                var results = [SearchTextFieldItem]()
                for area in areas {
                    results.append(SearchTextFieldItem(title: area.name, subtitle: area.province?.name, image: nil))
                }
                DispatchQueue.main.async {
                    callback(results)
                }
            } else {
                DispatchQueue.main.async {
                    callback([])
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension AddressFieldTableViewCell : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.update(field: field, with: textView.text)
    }
}

// MARK: - UITextFieldDelegate
extension AddressFieldTableViewCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, field == .phone && text == "+" && string == "" {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.trimmingCharacters(in: CharacterSet.alphanumerics).isTrimmedEmpty && !text.isTrimmedEmpty {
            self.delegate?.update(field: field, with: text)
        }
    }
}
