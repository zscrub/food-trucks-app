//
//  EditBusinessScheduleViewController.swift
//  food-trucks
//
//  Created by Zack on 7/5/21.
//

import UIKit

class EditBusinessScheduleViewController: UIViewController {
    @IBOutlet weak var id_text: UITextField!
    @IBOutlet weak var date_text: UITextField!
    
    var id_ = ""
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBusinessDate(_ sender: Any) {
        print("id is \(id_text.text!) and \(date_text.text!)")
        id_ = id_text.text!
        date = date_text.text!
        
        
        let stringUrl = "https://81010fc46b4b.ngrok.io/businesses/update_date?id=\(id_)&date=\(date)"
        

        let url_ = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url_!)
        var request = URLRequest(url: url_!)
        request.httpMethod = "PATCH"
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        task.resume()
       
    }
}
