//
//  LoginViewController.swift
//  food-trucks
//
//  Created by Zack on 6/22/21.

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var welcomeStr_ = ""
    var user_ = ""
    var password_ = ""
    
    @IBAction func login_butn(_ sender: Any) {
        user_ = username_text.text!
        password_ = password_text.text!

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let zip_vc = segue.destination as! ZipCodeViewController
        zip_vc.user_ = self.user_
        zip_vc.password_ = self.password_
    }
    
    func login_(user: String, password: String, loginCompletionHandler: @escaping ((String?, Error?)->Void) ) {
    //        let login_ = String(describing: username_text.text!)
    //        let password_ = String(describing: password_text.text!)
    //
    //        ngrok
            let url_ = "https://zachary.yadiiiig.com/api/"
    //        let params = ["username":username_text.text!, "password":password_text.text!]
            var requestBodyComponenets = URLComponents()
        requestBodyComponenets.queryItems = [URLQueryItem(name: "username", value: "\(user)"),
                                                 URLQueryItem(name: "password", value:"\(password)")]


            var request = URLRequest(url: URL(string: "\(url_)/users/auth/token")!)
            request.httpMethod = "POST"
            request.httpBody = requestBodyComponenets.query?.data(using: .utf8)
            //        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

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
                    let json = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, String>
                    if json != nil {
                        if json?["detail"] != "Invalid credentials" {
                            print("logged in!")
                            loginCompletionHandler(self.user_, nil)
                            self.welcomeStr_ = "Welcome, \(user))"
                        }
                        else {
                            print("not logged in :(")
                        }
                    
                    }
                } catch {
                    print("error")
                    loginCompletionHandler(nil, error)
                }

            })
            task.resume()
    }
    
}
