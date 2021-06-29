//
//  ZipCodeViewController.swift
//  food-trucks
//
//  Created by Zack on 6/27/21.
//

import UIKit

class ZipCodeViewController: UIViewController {
    @IBOutlet weak var allText: UITextView!
    @IBOutlet weak var place: UILabel!
    @IBOutlet public weak var zipcode: UITextField!
    
    var zip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    
    @IBAction func search(_ sender: UIButton) {
        zip = zipcode.text!
        performSegue(withIdentifier: "zip", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        vc.zip_ = self.zip
//        getData(zip: "07054")
    }
}

func fetchUser(zip: String, zipCompletionHandler: @escaping ([Response]?, Error?) -> Void) {
    let url = URL(string: "https://us1.locationiq.com/v1/search.php?key=pk.9684621c328d7f6c2548e794b8b05772&postalcode=\(zip)&country=us&format=json")!
    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

    guard let data = data else { return }
    do {
      // parse json data and return it
        let decoder = JSONDecoder()
        var result: [Response]?
        result = try decoder.decode([Response].self, from: data)
        if let zipData = result {
            zipCompletionHandler(zipData, nil)
      }
      
    } catch let parseErr {
      print("JSON Parsing Error", parseErr)
      zipCompletionHandler(nil, parseErr)
    }

  })
  
  task.resume()
  // function will end here and return
  // then after receiving HTTP response, the completionHandler will be called
}


public func getData(zip: String) -> String {
    var info = ""
    var box = [String]()
    if zip != "" {
//        allText.text = "Loading..."
        let url = "https://us1.locationiq.com/v1/search.php?key=pk.9684621c328d7f6c2548e794b8b05772&postalcode=" + zip + "&country=us&format=json"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {(data, response, error) in
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
            
            
            print("getting data...")
//            allText.text = zip + " " + json[0].display_name + "\n latitude: " + json[0].lat + "\n longitude: " + json[0].lon
            print("info before: \(info)")
            info += "\(json[0].display_name)\n\(json[0].lat)\n\(json[0].lon)"
            print("info after: \(info)")

            box.append(contentsOf: json[0].boundingbox)
            print("data recieved")
            
//            return (json[0].display_name, zip, json[0].boundingbox)
            
        })
    task.resume()
    }
//    print("and finally \(info)")
return info
}

struct Response: Codable {
    let place_id: String
    let lat: String
    let lon: String
    let boundingbox: Array<String>
    let display_name: String
}
