//
//  BaseViewController.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import Cartography

class BaseViewController: UIViewController {
    
    fileprivate var loadingView: LoaderView?
    fileprivate var loadingOverlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
        self.title = screenTitle
        self.view.backgroundColor = UIColor.white
    }
    
    func setupBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .plain, target: nil, action: nil)
    }
    
    var screenTitle: String? {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Loader view
extension BaseViewController {
    func setLoading(_ loading: Bool) {
        if loading {
            if loadingOverlayView == nil {
                loadingOverlayView = self.createLoadingOverlayView()
                self.view.addSubview(loadingOverlayView!)
                constrain(self.view, loadingOverlayView!) { (view, overlay) in
                    overlay.edges == inset(view.edges, 0, 0, 0, 0)
                }
                
                loadingView = self.createLoaderView()
                loadingOverlayView!.addSubview(loadingView!)
                constrain(loadingOverlayView!, loadingView!) { (overlay, loading) in
                    loading.centerX == overlay.centerX
                    loading.centerY == overlay.centerY
                }
                loadingView!.startAnimation()
                
                UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
                    self?.loadingOverlayView!.alpha = 1.0
                })
            }
        } else {
            if loadingOverlayView != nil {
                UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
                    self?.loadingOverlayView!.alpha = 0.0
                    }, completion: { [weak self] (_) -> Void in
                        self?.loadingView?.stopAnimation()
                        self?.loadingOverlayView?.removeFromSuperview()
                        self?.loadingView = nil
                        self?.loadingOverlayView = nil
                })
            }
        }
    }
    
    func createLoadingOverlayView() -> UIView {
        let result = UIView(frame: CGRect.zero)
        result.backgroundColor = UIColor.clear
        result.alpha = 0.0
        return result
    }
    
    func createLoaderView() -> LoaderView {
        return LoaderView(size: CGSize(width: 75, height: 75))
    }
}

// MARK: - Alert support
extension BaseViewController {
    func showAlert(title: String?, message: String?, action style: UIAlertActionStyle, with completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK".localized, style: style) { (action) in
            if let completion = completion {
                completion()
            }
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String?, message: String?) {
        self.showAlert(title: title, message: message, action: .cancel, with: nil)
    }
}
