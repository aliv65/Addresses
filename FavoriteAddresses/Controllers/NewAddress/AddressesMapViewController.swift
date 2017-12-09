//
//  AddressesMapViewController.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 05.12.2017.
//  Copyright © 2017 Aleksander Ivanin. All rights reserved.
//

import UIKit
import MapKit
import Cartography

class AddressesMapViewController: BaseViewController {
    var mapView: MKMapView!
    var myLocationButton: UIButton!
    var confirmButton: UIButton!
    var addressFieldsView: AddressFieldsView!
    var expandTapRecognizer: UITapGestureRecognizer!
    var setPinTapGestureRecognizer: UITapGestureRecognizer!
    
    var resultSearchController: UISearchController? = nil
    
    var animatedConstraintGroup = ConstraintGroup()
    
    var locationManager: CLLocationManager
    var userLocationAnnotation: MKPointAnnotation
    var addressAnnotation: MKPointAnnotation
    
    fileprivate var prevLeftBarButtons: Array<UIBarButtonItem>? = nil
    fileprivate var prevRightBarButtons: Array<UIBarButtonItem>? = nil
    fileprivate var prevTitleView: UIView? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.locationManager = CLLocationManager()
        self.userLocationAnnotation = MKPointAnnotation()
        self.addressAnnotation = MKPointAnnotation()
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        configureSearchButton()
        configureLocationManager()
        setupUI()
    }
    
    override var screenTitle: String? {
        return R.string.localizable.addAddress()
    }
}

// MARK: - Конфигурация интерфейса и копмонентов контроллера
extension AddressesMapViewController {
    func configureSearchButton() {
        let searchItem = UIBarButtonItem(image: R.image.search(), style: .plain, target: self, action: #selector(searchPressed(_:)))
        self.navigationItem.rightBarButtonItem = searchItem
        var attributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black]
        if #available(iOS 11, *) {
            attributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        }
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
    }
    
    func configureLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    func setupUI() {
        mapView = MKMapView(frame: CGRect.zero)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        addressFieldsView = AddressFieldsView()
        addressFieldsView.delegate = self
        self.view.addSubview(addressFieldsView)
        
        animatedConstraintGroup = constrain(self.view, mapView, addressFieldsView) { (view, map, fields) in
            map.top == view.top
            map.left == view.left
            map.right == view.right
            map.bottom == view.bottom
            
            fields.top == map.bottom
            fields.left == map.left
            fields.bottom == view.bottom
            fields.right == map.right
        }
        
        expandTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.expandMapView(_:)))
        setPinTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.setPinAtTouchPoint(_:)))
        self.mapView.addGestureRecognizer(self.setPinTapGestureRecognizer)
        
        myLocationButton = UIButton(type: .custom)
        myLocationButton.setImage(R.image.myLocation(), for: .normal)
        myLocationButton.addTarget(self, action: #selector(myLocationPressed(_:)), for: .touchUpInside)
        mapView.addSubview(myLocationButton)
        
        confirmButton = UIButton.confirmGreenButton()
        confirmButton.setTitle(R.string.localizable.confirm(), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmAddressPressed(_:)), for: .touchUpInside)
        mapView.addSubview(confirmButton)
        
        constrain(mapView, confirmButton, myLocationButton) { (map, confirm, location) in
            confirm.left == map.left + 16
            confirm.right == map.right - 16
            confirm.bottom == map.bottom - 16
            
            location.right == confirm.right
            location.bottom == confirm.top - 16
            location.width == 40
            location.height == 40
        }
        
        confirmButton.isHidden = true
    }
    
    @objc
    private func searchPressed(_ sender: UIBarButtonItem) {
        self.showSearch()
    }
    
    @objc
    private func myLocationPressed(_ sender: UIButton) {
        self.moveToUserLocation()
    }
    
    @objc
    private func setPinAtTouchPoint(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.mapView)
        let touchCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        self.showLocation(at: touchCoordinate)
    }
    
    @objc
    private func confirmAddressPressed(_ sender: UIButton) {
        self.confirmAddress()
    }
    
    @objc
    private func expandMapView(_ sender: UITapGestureRecognizer) {
        self.expandMapView()
    }
}

// MARK: - Дополнительный функционал экрана
extension AddressesMapViewController {
    func showSearch() {
        prevLeftBarButtons = self.navigationItem.leftBarButtonItems
        prevRightBarButtons = self.navigationItem.rightBarButtonItems
        prevTitleView = self.navigationItem.titleView

        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.rightBarButtonItems = nil
        
        let locationSearchTable = LocationSearchTableViewController()
        locationSearchTable.mapView = mapView
        locationSearchTable.delegate = self
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.searchBar.placeholder = R.string.localizable.searchPlaceholder()
        resultSearchController?.searchBar.tintColor = UIColor.white
        resultSearchController?.searchBar.barTintColor = UIColor.white
        resultSearchController?.searchBar.delegate = self
        resultSearchController?.searchBar.becomeFirstResponder()
        resultSearchController?.searchBar.sizeToFit()
        
        if #available(iOS 11, *) {
            self.navigationItem.searchController = resultSearchController!
        } else {
            self.navigationItem.titleView = resultSearchController?.searchBar
        }
        self.present(resultSearchController!, animated: true, completion: nil)
    }
    
    func cancelSearch() {
        self.navigationItem.leftBarButtonItems = prevLeftBarButtons
        self.navigationItem.rightBarButtonItems = prevRightBarButtons
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = nil
        } else {
            self.navigationItem.titleView = prevTitleView
        }
        
        prevLeftBarButtons = nil
        prevRightBarButtons = nil
        
        resultSearchController = nil
    }
    
    func moveToUserLocation() {
        guard let userLocation = locationManager.location else {
            self.showError(message: "Unable to find user location")
            return
        }
        self.focusOnLocation(with: userLocation.coordinate)
    }
    
    func focusOnLocation(with coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(mapRegion, animated: true)
    }
    
    func showLocation(at coordinate: CLLocationCoordinate2D) {
        mapView.removeAnnotation(addressAnnotation)
        addressAnnotation.coordinate = coordinate
        mapView.addAnnotation(addressAnnotation)
        self.focusOnLocation(with: addressAnnotation.coordinate)
        confirmButton.isHidden = false
    }
    
    func confirmAddress() {
        if resultSearchController != nil {
            self.cancelSearch()
        }
        
        self.setLoading(true)
        APIProvider.shared.addresses(for: addressAnnotation.coordinate.latitude, longitude: addressAnnotation.coordinate.longitude) { [weak self] (address, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.setLoading(false)
            if let error = error {
                strongSelf.showErrorAlert(title: R.string.localizable.error(), message: error.localizedDescription)
                return
            }
            if let address = address {
                strongSelf.addressFieldsView.savedDataFields = address.toDictionary()
                strongSelf.myLocationButton.alpha = 0
                strongSelf.confirmButton.alpha = 0
                UIView.animate(withDuration: 0.375, animations: {
                    constrain(clear: strongSelf.animatedConstraintGroup)
                    strongSelf.animatedConstraintGroup = constrain(strongSelf.view, strongSelf.mapView, strongSelf.addressFieldsView) { (view, map, fields) in
                        map.top == view.top
                        map.left == view.left
                        map.right == view.right
                        map.bottom == view.top + 109
                        
                        fields.top == map.bottom
                        fields.left == map.left
                        fields.bottom == view.bottom
                        fields.right == map.right
                    }
                    strongSelf.view.layoutIfNeeded()
                }) { (finish) in
                    strongSelf.myLocationButton.isHidden = true
                    strongSelf.confirmButton.isHidden = true
                    strongSelf.mapView.removeGestureRecognizer(strongSelf.setPinTapGestureRecognizer)
                    strongSelf.mapView.addGestureRecognizer(strongSelf.expandTapRecognizer)
                }
            } else {
                strongSelf.showError(message: R.string.localizable.parsedModelError())
            }
        }
    }
    
    func expandMapView() {
        UIView.animate(withDuration: 0.375, animations: {
            self.myLocationButton.alpha = 1
            self.confirmButton.alpha = 1
            constrain(clear: self.animatedConstraintGroup)
            self.animatedConstraintGroup = constrain(self.view, self.mapView, self.addressFieldsView) { (view, map, fields) in
                map.top == view.top
                map.left == view.left
                map.right == view.right
                map.bottom == view.bottom
                
                fields.top == map.bottom
                fields.left == map.left
                fields.bottom == view.bottom
                fields.right == map.right
            }
            self.view.layoutIfNeeded()
        }) { (finish) in
            self.myLocationButton.isHidden = false
            self.confirmButton.isHidden = false
            self.mapView.removeGestureRecognizer(self.expandTapRecognizer)
            self.mapView.addGestureRecognizer(self.setPinTapGestureRecognizer)
        }
    }
}

// MARK: - CLLoactionManagerDelegate
extension AddressesMapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.focusOnLocation(with: location.coordinate)
            userLocationAnnotation.coordinate = location.coordinate
            mapView.addAnnotation(userLocationAnnotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showErrorAlert(title: R.string.localizable.error(), message: error.localizedDescription)
    }
}

// MARK: - MKMapViewDelegate
extension AddressesMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(addressAnnotation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AddressAnnotationPin")
            annotationView.canShowCallout = true
            annotationView.image = R.image.pin()
            
            return annotationView
        }
        return nil
    }
}

// MARK: - UISearchBarDelegate
extension AddressesMapViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cancelSearch()
    }
}

// MARK: - LocationSearchDelegate
extension AddressesMapViewController : LocationSearchDelegate {
    func show(placemark: MKPlacemark) {
        self.showLocation(at: placemark.coordinate)
    }
}

// MARK: - AddressFieldsDelegate
extension AddressesMapViewController : AddressFieldsDelegate {
    func save(model: AddressResponseModel) {
        AddressManager.shared.save(with: model) { (success) in
            if success {
                self.showAlertController(title: R.string.localizable.success(), message: R.string.localizable.addressSavedSuccess(), action: .default) {
                    self.expandMapView()
                }
            } else {
                self.showErrorAlert(title: R.string.localizable.error(), message: R.string.localizable.addressSavedError())
            }
        }
    }
    
    func showError(message: String) {
        self.showErrorAlert(title: R.string.localizable.error(), message: message)
    }
}
