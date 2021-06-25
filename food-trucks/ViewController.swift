//
//  ViewController.swift
//  food-trucks
//
//  Created by Zack on 6/22/21.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var allText: UITextView!
//    @IBOutlet weak var allText_: UITextView!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var zipcode: UITextField!
//    @IBAction func displayResults(data: [String]) {
//        allText.text = "\(data[0])\n"
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        getData(zip: (zipcode.text!))
//        displayResults(data: [""])
//        allText.text = ""
    }
    
    @IBAction func search(_ sender: UIButton) {
//        allText.text += "Zip code: \(zipcode.text!)\n"
        getData(zip: (zipcode.text!))
    }
    
    private func getData(zip: String) {
        if zip != "" {
            allText.text = "Loading..."
            let url = "https://us1.locationiq.com/v1/search.php?key=pk.9684621c328d7f6c2548e794b8b05772&postalcode=" + zip + "&country=us&format=json"
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
                guard let data = data, error==nil else {
                    print("error")
                    return
                }
                var result: [Response]?
                do {
                    result = try JSONDecoder().decode([Response].self, from: data)
                }
                catch {
                    print(String(describing: error))
                }
                
                guard let json = result else {
                    return
                }
                
                print("changing label...")
                self.allText.text = zip + " " + json[0].display_name + "\n latitude: " + json[0].lat + "\n longitude: " + json[0].lon
                print("label changed")
            })
            task.resume()
            }
        
        }
}

struct Response: Codable {
    let place_id: String
    let lat: String
    let lon: String
    let boundingbox: Array<String>
    let display_name: String
}

