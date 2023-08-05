//
//  Capital.swift
//  Project16
//
//  Created by Derya Çayıroğlu on 3.08.2023.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiUrl: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiUrl: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiUrl = wikiUrl
    }

}
