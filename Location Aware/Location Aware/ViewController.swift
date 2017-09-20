//
//  ViewController.swift
//  Location Aware
//
//  Created by Claudio Tezzin Jeremias on 19/09/17.
//  Copyright © 2017 Claudio Tezzin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        self.latitude.text = String(userLocation.coordinate.latitude)
        self.longitude.text = String(userLocation.coordinate.longitude)
        self.altitude.text = String(userLocation.altitude)
        self.course.text = String(userLocation.course)
        self.speed.text = String(userLocation.speed)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in

            if error != nil {
                print(error.debugDescription)
            } else {

                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if let subThoroughfare = placemark.subThoroughfare {
                        address += subThoroughfare + " "
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {
                        address += thoroughfare + "\n"
                    }
                    
                    if let subLocality = placemark.subLocality {
                        address += subLocality + "\n"
                    }
                    
                    if let subAdmArea = placemark.subAdministrativeArea {
                        address += subAdmArea + "\n"
                    }
                    
                    if let postalCode = placemark.postalCode {
                        address += postalCode + "\n"
                    }
                    
                    if let country = placemark.country {
                        address += country + "\n"
                    }
                    
                    self.address.text = address
                }

            }

        }
    }

}

