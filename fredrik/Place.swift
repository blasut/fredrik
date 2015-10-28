//
//  Place.swift
//  fredrik
//
//  Created by jite on 28/10/2015.
//  Copyright © 2015 Tre Bitar. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class Place: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let age_limit: String
    let opening_hours: Dictionary<String, JSON>
    let contact: Dictionary<String, JSON>
    let street: String
    let city: String
    
    init(title: String,
        age_limit: String,
        opening_hours: Dictionary<String, JSON>,
        contact: Dictionary<String, JSON>,
        street: String,
        city: String,
        coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.age_limit = age_limit
        self.opening_hours = opening_hours
        self.contact = contact
        self.street = street
        self.city = city
        self.coordinate = coordinate
        
        super.init()
    }
    
    class func fromJSON(json: JSON) -> Place? {
        let title: String = json["name"].stringValue
        
        let age_limit: String = json["age-limit"].stringValue
        
        let opening_hours: Dictionary<String, JSON> = json["opening-hours"].dictionaryValue
        
        let contact: Dictionary<String, JSON> = json["contact"].dictionaryValue
        
        let street: String = json["location"]["street"].stringValue
        let city: String = json["location"]["city"].stringValue
        
        let latitude = json["location"]["latitude"].doubleValue
        let longitude = json["location"]["longitude"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return Place(title: title,
            age_limit: age_limit,
            opening_hours: opening_hours,
            contact: contact,
            street: street,
            city: city,
            coordinate: coordinate)
    }
    
    var subtitle: String? {
        return "Öppet! Stänger kl.03. 18-årsgräns";
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinColor() -> UIColor!  {
        switch age_limit {
        case "20":
            return UIColor.blueColor()
        case "18":
            return UIColor.purpleColor()
        default:
            return UIColor.redColor()
        }
    }
}