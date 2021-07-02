//
//  SignUpViewController.swift
//  food-trucks
//
//  Created by Zack on 6/22/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var accCreatedLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createAcc() {
        let username_ = String(describing: username.text!)
        let email_ = String(describing: email.text!)
        let password_ = String(describing: password.text!)
        let account_type = "c"
        
        let url_ = "https://0d0350dc133d.ngrok.io"
        
        let params = ["username":username_, "email":email_, "password":password_, "account_type":account_type]

        var request = URLRequest(url: URL(string: "\(url_)/users/new")!)
//        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users/new")!)
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
