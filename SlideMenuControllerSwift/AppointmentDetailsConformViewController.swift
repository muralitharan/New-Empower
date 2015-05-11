//
//  AppointmentDetailsConformViewController.swift
//  Empower
//
//  Created by Muralitharan on 10/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit

class AppointmentDetailsConformViewController : UIViewController {
    
    var titles: [String]!
    var values: [String]!
    @IBOutlet private weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Schedule Appointment"
        titles = ["Physician", "Location", "Appointment Type", "Patient Type", "Preferred Day(s) and Time", "Preferred Method of Contact"]
        values = ["Dr. Michael Remillard", "BCHS East Birmingham, AL", "Follow-up VIsit", "Existing Patient", "Wednesday (morning), Thursday (afternoon)", "Patient Portal"]
        tblView.estimatedRowHeight = 40
        tblView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func backButton_Tapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    @IBAction func buttonSubmit_Tapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AppointmentTableViewCell") as! AppointmentTableViewCell
        cell.fillData(title: titles[indexPath.row], value: values[indexPath.row])
        cell.backgroundColorView?.backgroundColor = indexPath.row%2 == 1 ? UIColor.whiteColor() : UIColor(red: 220/255.0, green: 225/255.0, blue: 235/255.0, alpha: 0.6)
        return cell
    }
}

class AppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet internal weak var backgroundColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func fillData(#title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}