//
//  MapViewController.swift
//  food-trucks
//
//  Created by Zack on 6/27/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
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
//                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                    let region = MKCoordinateRegion(center: location, span: span)
//                    print(lat, lon)
//                    self.mapView.setRegion(region, animated: true)
//                    let annotation = MKPointAnnotation()
//                    annotation.coordinate = location
//                    annotation.title = self.zip_
//                    annotation.subtitle = data[0].display_name
//                    self.mapView.addAnnotation(annotation)
//
//                    let region = CLCircularRegion(center: location, radius: 15000, identifier: "zipCircle")

                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            self.mapView.removeOverlays(self.mapView.overlays)
                            self.mapView.addOverlay(MKCircle(center: location, radius: 15000))
                        }
                    }
                    
                }
            }
          }
        })

    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.blue
            return circleRenderer
        }
    return MKOverlayRenderer(overlay: overlay)
    }
}
