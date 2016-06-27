//
//  TableViewController.swift
//  TaipeiOpenData
//
//  Created by 蔡舜珵 on 2016/6/21.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
class TableViewController: UITableViewController {
    var schoolArray = [School]()
    let imageCellIdentifier = "ImageTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: imageCellIdentifier,bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
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
                    schools.address = school["o_tlc_agency_address"].stringValue
                    schools.photoLink = school["o_tlc_agency_img_front"].stringValue
                    
                    self.schoolArray.append(schools)
                }
                self.tableView.reloadData()
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schoolArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0 :
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = schoolArray[indexPath.row].name
        let url = NSURL(string: schoolArray[indexPath.row].photoLink!)
        cell.imageView?.sd_setImageWithURL(url, placeholderImage: nil)
        // Configure the cell...

        return cell
        case 1 :
            let cell = tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier, forIndexPath: indexPath) as! ImageTableViewCell
            cell.name.text = schoolArray[indexPath.row].name
            let url = NSURL(string: schoolArray[indexPath.row].photoLink!)
            cell.picture.clipsToBounds = true

            cell.picture.sd_setImageWithURL(url, placeholderImage: nil)
            cell.address.text = schoolArray[indexPath.row].address
            return cell
        default:
            break
        
        }
        return UITableViewCell()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class School{
    var name: String?
    var address: String?
    var photoLink:String?
    
}
