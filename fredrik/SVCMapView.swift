//
//  SVCMapView.swift
//  fredrik
//
//  Created by jite on 28/10/2015.
//  Copyright © 2015 Tre Bitar. All rights reserved.
//

import Foundation
import MapKit

extension SecondViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -10, y: 10)
                view.rightCalloutAccessoryView = UIButton.init(type: (.DetailDisclosure)) as UIView
            }
            view.pinTintColor = annotation.pinColor()
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! Place
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}