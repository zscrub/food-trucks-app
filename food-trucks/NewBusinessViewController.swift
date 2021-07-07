//
//  NewBusinessViewController.swift
//  food-trucks
//
//  Created by Zack on 7/6/21.
//

import UIKit

class NewBusinessViewController: UIViewController {
    @IBOutlet weak var name_text: UITextField!
    @IBOutlet weak var date_text: UITextField!
    @IBOutlet weak var description_text: UITextField!
    @IBOutlet weak var lat_text: UITextField!
    @IBOutlet weak var lon_text: UITextField!
    @IBOutlet weak var ownerid_text: UITextField!
    
    var name = ""
    var date = ""
    var description_ = ""
    var lat = ""
    var lon = ""
    var ownerid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func submitNewBusiness(_ sender: Any) {
        name = name_text.text!
        date = date_text.text!
        description_ = description_text.text!
        lat = lat_text.text!
        lon = lon_text.text!
        ownerid = ownerid_text.text!
        let url_ = "https://zachary.yadiiiig.com/api/"
        //
        let params = ["name":name, "date":date, "description":description_, "lat":lat, "lng":lon, "ownerid":ownerid]
        //
        var request = URLRequest(url: URL(string: "\(url_)/businesses/new")!)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else { return }
            if response != nil {
                print(response!)
            }
            else {
                print("No response... API down??")
            }
        
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        
        })
        task.resume()

    }
}
