//
//  UIButton+FavoriteAddresses.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 05.12.2017.
//  Copyright © 2017 Aleksander Ivanin. All rights reserved.
//

import UIKit
import Cartography

extension UIButton {
    class func confirmGreenButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.buttonBackgroundColor
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        constrain(button) { (button) in
            button.height == 52
        }
        
        return button
    }
}
