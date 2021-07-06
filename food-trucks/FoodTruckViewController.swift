//
//  FoodTruckViewController.swift
//  food-trucks
//
//  Created by Zack on 7/5/21.
//

import UIKit

class FoodTruckViewController: UIViewController {
    @IBOutlet weak var zipcode: UITextField!
    
//    var zip = ""
    var zip = MapViewController().zip_
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func search_(_ sender: Any) {
        zip = zipcode.text!
//        print("zipcode is \(zip)")
        performSegue(withIdentifier: "zip2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "zip2" {
            let vc = segue.destination as! MapViewController
            vc.zip_ = self.zip
        }
    }
}
