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
//                    let location2 = CLLocationCoordinate2D(latitude: CLLocationDegrees(40.69051), longitude: CLLocationDegrees(-74.29569))
                    
                    self.mapView.setCenter(location, animated: true)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
                    let region = MKCoordinateRegion(center: location, span: span)
                    print(lat, lon)
                    self.mapView.setRegion(region, animated: true)
                    
                    // annotations
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.zip_
                    annotation.subtitle = data[0].display_name
                    
//                    let annotation2 = MKPointAnnotation()
//                    annotation2.coordinate = location2
//                    annotation2.title = "Halal Guys"
//                    annotation2.subtitle = "Even more lamb!!"

                    self.mapView.addAnnotation(annotation)
//                    self.mapView.addAnnotation(annotation2)
                    
                    // API call to get all food truck locations
                    let url = URL(string: "https://240903b1e9b1.ngrok.io/businesses")!
                    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

                    guard let data = data else { return }
                    do {
                      // parse json data and return it
                        let decoder = JSONDecoder()
                        var result: [Business]?
                        result = try decoder.decode([Business].self, from: data)
                        if let locationData = result {
                            print(locationData)
                            for i in 0..<locationData.count {
                                print(i)
                                let latDouble_ = Double(locationData[i].lat)
                                let lonDouble_ = Double(locationData[i].lng)
                                let location_ = CLLocationCoordinate2D(latitude: CLLocationDegrees(latDouble_!), longitude: CLLocationDegrees(lonDouble_!))
                                let annotation_ = MKPointAnnotation()
                                annotation_.coordinate = location_
                                annotation_.title = locationData[i].name
                                annotation_.subtitle = locationData[i].description
                                self.mapView.addAnnotation(annotation_)
                            }
                      }
                      
                    } catch let parseErr {
                      print("JSON Parsing Error", parseErr)
                      
                    }

                  })
                  
                  task.resume()
                  // function will end here and return
                  // then after receiving HTTP response, the completionHandler will be called
                    
                    
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

struct Business: Codable {
    let id: Int
    let name: String
    let date: String
    let lat: String
    let lng: String
    let description: String
    let ownerid: Int
}

//{
//    "id": 1,
//    "name": "halal guys 2.0",
//    "date": "07/14/21",
//    "lat": "40.8594",
//    "lng": "-74.4134",
//    "description": "got more lamb baby",
//    "ownerid": 25
//},
