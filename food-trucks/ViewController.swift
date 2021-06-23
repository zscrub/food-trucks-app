//
//  ViewController.swift
//  food-trucks
//
//  Created by Zack on 6/22/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var place: UILabel!
    @IBAction func displayResults(data: String) {
        place.text = "test"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://us1.locationiq.com/v1/search.php?key=pk.9684621c328d7f6c2548e794b8b05772&postalcode=07054&country=us&format=json"
        getData(from: url)
        displayResults(data: "fuck me")
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error==nil else {
                print("error")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("response failed \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.place_id)
            print(json.results.boundingbox)
            print(json.results.lat)
            print(json.results.lng)
            self.displayResults(data: "how about now")
        })
        task.resume()
    }
}


struct Response: Codable {
    let results: ZipCodeData
    let place_id: Int
}

struct ZipCodeData: Codable{
    let lat: Float
    let lng: Float
    let boundingbox: Array<Float>
    let display_name: String
}
