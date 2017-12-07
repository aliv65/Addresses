//
//  LoaderView.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

class LoaderView: UIView {
    var size: CGSize
    var isAnimating = false
    
    public init(size: CGSize) {
        self.size = size
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
        self.isUserInteractionEnabled = false
        
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        overlay.layer.cornerRadius = 8
        overlay.clipsToBounds = true
        let overlayFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 75, height: 75))
        overlay.frame = overlayFrame
        self.addSubview(overlay)
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        self.addSubview(activityView)
        constrain(self, activityView) { (view, activity) in
            activity.centerX == view.centerX
            activity.centerY == view.centerY
            view.width == size.width
            view.height == size.height
        }
        
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    open func startAnimation() -> Bool {
        guard !isAnimating else {
            return false
        }
        self.isHidden = false
        isAnimating = true
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
        return true
    }
    
    @discardableResult
    open func stopAnimation() -> Bool {
        guard isAnimating else {
            return false
        }
        reset()
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        }
        return true
    }
    
    open func reset() {
        isAnimating = false
        self.isHidden = true
    }
}
