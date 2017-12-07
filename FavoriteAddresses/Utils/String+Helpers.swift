//
//  String+Helpers.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 05.12.2017.
//  Copyright © 2017 Aleksander Ivanin. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var isTrimmedEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
