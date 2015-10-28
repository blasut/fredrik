//
//  SecondViewController.swift
//  fredrik
//
//  Created by jite on 28/10/2015.
//  Copyright © 2015 Tre Bitar. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    
    var places = [Place]()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 59.3290575, longitude: 18.0516854)
        centerMapOnLocation(initialLocation)
        
        loadInitialData()
        
        mapView.addAnnotations(places)
        
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let regionRadius: CLLocationDistance = 5000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        print("load initial data");
        let fileName = NSBundle.mainBundle().pathForResource("Places", ofType: "json");
        do {
            print(fileName);
            let data: NSData = try NSData(contentsOfFile: fileName!,
                                          options: NSDataReadingOptions(rawValue: 0))
            
            let json = JSON(data: data)
            
            print(json);
            
            for (_,placeJSON):(String, JSON) in json["data"] {
                print(placeJSON);
                let place = Place.fromJSON(placeJSON)
                print(place);
                places.append(place!)
            }
        } catch {
            print(error);
        }
        
    }
}

