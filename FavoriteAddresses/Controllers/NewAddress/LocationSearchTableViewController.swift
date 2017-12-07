//
//  LocationSearchTableViewController.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import UIKit
import MapKit

protocol LocationSearchDelegate: class {
    func show(placemark: MKPlacemark)
}

class LocationSearchTableViewController: UITableViewController {
    var mapView: MKMapView? = nil
    var matchingItems: [MKMapItem] = []
    weak var delegate: LocationSearchDelegate?
    
    var reuseIdentifier: String = "LocationSearchCell"
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}

// MARK: - UISearchResultsUpdating
extension LocationSearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else {
                return
        }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension LocationSearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
}

// MARK: - Table view delegate
extension LocationSearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        self.delegate?.show(placemark: selectedItem)
        self.dismiss(animated: true, completion: nil)
    }
}
