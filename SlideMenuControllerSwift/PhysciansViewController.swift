//
//  PhysciansViewController.swift
//  Empower
//
//  Created by Muralitharan on 08/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit

protocol AppointmentPhysicianLocationDelegate: class {
    func updatePhysician(physician: Physician)
}

class PhysciansViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate:AppointmentPhysicianLocationDelegate!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select a Physician"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.physicians.count
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let phsyicianCell = tableView.dequeueReusableCellWithIdentifier("PhysicianCell") as! PhysicianCell
     let physician = user.physicians[indexPath.row]
     phsyicianCell.nameLabel.text = physician.name
     phsyicianCell.specialityLabel.text = physician.name
     phsyicianCell.address.text = physician.address1
     phsyicianCell.addressLabel2.text = physician.address3
     phsyicianCell.addressLabel3.text = physician.address3
     phsyicianCell.profileImageView.image = physician.profilePic
        
     return phsyicianCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate.updatePhysician(user.physicians[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func dissmissButton_Tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

class PhysicianCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var address: LabelValue!
    
    @IBOutlet weak var addressLabel2: LabelAddress!
    @IBOutlet weak var addressLabel3: LabelAddress!
    override func layoutSubviews() {
        super.layoutSubviews()
        panelView.layer.cornerRadius = 3.0
        panelView.layer.borderColor = UIColor.blackColor().CGColor
        panelView.layer.borderWidth = 0.5
    }
}