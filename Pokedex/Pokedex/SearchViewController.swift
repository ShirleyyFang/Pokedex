//
//  SearchViewController.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 4/27/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
}
//MARK: - CCLocationManagerDelegate
extension SearchViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let clLocation = CLLocation(latitude:lat,longitude: lon)

            AppDelegate.geoCoder.reverseGeocodeLocation(clLocation){ placemarks, _ in
                if let place = placemarks?.first {
                    let description = "\(place.locality!)"
                    self.locationLabel.text = "🌵🌵\(description)"
                }else{
                    print("Find location error")
                }
        }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
