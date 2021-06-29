//
//  MapViewController.swift
//  food-trucks
//
//  Created by Zack on 6/27/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var allText: UITextView!
    
    var zip_ = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        allText.text = zip_
        
        fetchUser(zip: zip_, zipCompletionHandler: { data, error in
          if let data = data {
            print("display_name is \(data[0].display_name)")
            self.allText.text = "\(data[0].display_name),\n\(data[0].lat)\n\(data[0].lon)"
          }
        })

        // Do any additional setup after loading the view.
    }

}
