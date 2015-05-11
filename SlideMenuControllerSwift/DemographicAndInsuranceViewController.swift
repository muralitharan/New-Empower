//
//  DemographicAndInsuranceViewController.swift
//  Empower
//
//  Created by Muralitharan on 10/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit

class DemographicAndInsuranceViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var titles: [String]!
    var values: [String]!
    @IBOutlet private weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Schedule Appointment"
        titles = ["First Name", "Middle Name", "Last Name", "Date of Birth", "Gender", "Phone", "Address1", "Address2", "City", "State/Province", "Zip/Postal Code", "Country"]
        values = ["Joyce", "M", "Campbell", "10/18/1975", "Female", "205-334-3344", "2534 21st Street South", "Suite 1001", "Birmingham", "Alabama", "35244", "United States"]
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DemographicTableCell") as! DemographicTableCell
        cell.fillData(title: titles[indexPath.row], value: values[indexPath.row])
        cell.backgroundColorView?.backgroundColor = indexPath.row%2 == 1 ? UIColor.whiteColor() : UIColor(red: 220/255.0, green: 225/255.0, blue: 235/255.0, alpha: 0.6)
        return cell
    }
}

class DemographicTableCell: UITableViewCell {
    
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
