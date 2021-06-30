//
//  MapViewController.swift
//  food-trucks
//
//  Created by Zack on 6/27/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var allText: UITextView!
    
    
    var zip_ = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
//        allText.text = zip_

        getData(zip: zip_, zipCompletionHandler: { data, error in
          if let data = data {
            print("display_name is \(data[0].display_name)")
            let lat = data[0].lat
            let lon = data[0].lon
            if let latDouble = Double(lat) {
                if let lonDouble = Double(lon) {
                    let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latDouble), longitude: CLLocationDegrees(lonDouble))
                    
                    self.mapView.setCenter(location, animated: true)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
                    let region = MKCoordinateRegion(center: location, span: span)
                    print(lat, lon)
                    self.mapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.zip_
                    annotation.subtitle = data[0].display_name
                    self.mapView.addAnnotation(annotation)

                    
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            self.showCircle(coordinate: location, radius: 15000)
                            self.mapView.delegate = self
                        }
                    }
                    
                }
            }
          }
        })
    }
    func showCircle(coordinate: CLLocationCoordinate2D,
                    radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate,
                              radius: radius)
        mapView.addOverlay(circle)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // If you want to include other shapes, then this check is needed.
        // If you only want circles, then remove it.
        
        let circleOverlay = overlay as! MKCircle
        let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
        circleRenderer.fillColor = .black
        circleRenderer.alpha = 0.25

        return circleRenderer
        
    }
}
