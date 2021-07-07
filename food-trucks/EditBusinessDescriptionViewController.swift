//
//  EditBusinessDescriptionViewController.swift
//  food-trucks
//
//  Created by Zack on 7/5/21.
//

import UIKit

class EditBusinessDescriptionViewController: UIViewController {
    @IBOutlet public weak var id_text: UITextField!
    @IBOutlet public weak var description_text: UITextField!
    
    var id = ""
    var description_ = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func submitBusinessDescription(_ sender: Any) {
        print("id is \(id_text.text!) and \(description_text.text!)")
        id = id_text.text!
        description_ = description_text.text!
        print("id is \(id) and \(description_)")
        
        let stringUrl = "https://zachary.yadiiiig.com/api/businesses/update_description?id=\(id)&description=\(description_)"
        let url_ = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url_!)
        var request = URLRequest(url: url_!)
        request.httpMethod = "PATCH"
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        task.resume()
        
    }

}
