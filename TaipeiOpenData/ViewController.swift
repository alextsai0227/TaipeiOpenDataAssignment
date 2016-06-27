//
//  ViewController.swift
//  TaipeiOpenData
//
//  Created by 蔡舜珵 on 2016/6/21.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
     var schoolArray = [School]()
    @IBAction func loadData(sender: AnyObject) {
        let urlString: String = "http://data.taipei/opendata/datalist/apiAccess"
        
        Alamofire.request(.GET, urlString, parameters: ["scope": "resourceAquire","rid": "11f11d42-bdd8-45d0-9493-8134b2e494e9","limit": "10","offset": "5"]).responseJSON { response in
            //print("Response:\(response.result.value)")
            
            if let data = response.result.value{
                let json = JSON(data)
                
                let schoolList = json["result"]["results"].arrayValue
                
                for school in schoolList {
                   // print("schoo name: \(school["o_tlc_agency_name"].stringValue)")
                 let schools = School()
                schools.name = school["o_tlc_agency_name"].stringValue
                schools.address = school["o_tlc_agency_adress"].stringValue
                schools.photoLink = school["o_tlc_agency_img_front"].stringValue
                
                self.schoolArray.append(schools)
                }
            
            }

        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

