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
    
    @IBOutlet private weak var physicianLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var appointmentTypeLabel: UILabel!
    @IBOutlet private weak var patientTypeLabel: UILabel!
    @IBOutlet private weak var preferredDayAndTimeLabel: UILabel!
    @IBOutlet private weak var preferredMethodOfContactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Schedule Appointment"
    }
    
    @IBAction func backButton_Tapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}