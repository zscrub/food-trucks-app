//
//  LoginViewController.swift
//  food-trucks
//
//  Created by Zack on 6/22/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password_: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func login_btn(_ sender: Any) {
        let login_ = String(describing: login.text!)
        let password_ = String(describing: password_.text!)
        let account_type = "c"
        
        // ngrok 
        let url_ = "https://0b7703232450.ngrok.io"
        
        let params = ["username":login_, "email":login_, "password":password_, "account_type":account_type]

        var request = URLRequest(url: URL(string: "\(url_)/users/login")!)
    //        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/users/new")!)
        request.httpMethod = "GET"
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
