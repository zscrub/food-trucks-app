//
//  EditBusinessLocationViewController.swift
//  food-trucks
//
//  Created by Zack on 7/5/21.
//

import UIKit

class EditBusinessLocationViewController: UIViewController {
    @IBOutlet public weak var id_text: UITextField!
    @IBOutlet public weak var lat_text: UITextField!
    @IBOutlet public weak var lon_text: UITextField!
    
    var id_ = ""
    var lat = ""
    var lon = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBusinessLocation(_ sender: Any) {
        print("id is \(id_text.text!), \(lat_text.text!) and \(lon_text.text!)")
        id_ = id_text.text!
        lat = lat_text.text!
        lon = lon_text.text!
        
        let stringUrl = "https://zachary.yadiiiig.com/api/businesses/update_location?id=\(id_)&lat=\(lat)&lng=\(lon)"
        

        let url_ = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url_!)
        var request = URLRequest(url: url_!)
        request.httpMethod = "PATCH"
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        task.resume()
        
    }
}
