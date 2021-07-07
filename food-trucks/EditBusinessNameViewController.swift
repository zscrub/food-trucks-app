//
//  EditBusinessNameViewController.swift
//  food-trucks
//
//  Created by Zack on 7/5/21.
//

import UIKit

class EditBusinessNameViewController: UIViewController {
    @IBOutlet public weak var id_text: UITextField!
    @IBOutlet public weak var name_text: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    var id_ = ""
    var name_ = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func submitBusinessName(_ sender: UIButton) {
        print("id is \(id_text.text!) and \(name_text.text!)")
        id_ = id_text.text!
        name_ = name_text.text!
        print("id is \(id_) and \(name_)")
        
        let stringUrl = "https://zachary.yadiiiig.com/api/businesses/update_name?id=\(id_)&name=\(name_)"
        let url_ = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url_!)
        var request = URLRequest(url: url_!)
        request.httpMethod = "PATCH"
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        task.resume()
        
    }
}
