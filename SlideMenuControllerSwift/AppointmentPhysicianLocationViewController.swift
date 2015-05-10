//
//  AppointmentPhysicianLocationViewController.swift
//  Empower
//
//  Created by Muralitharan on 08/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit
import MapKit




class AppointmentPhysicianLocationViewController: UIViewController,AppointmentPhysicianLocationDelegate, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    var user: User!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.selectedPhysician = user.physicians[0]
        navigationItem.title = "Schedule Appointment"
        setUpMapView()
    }
    
    @IBAction func physicianButton_Tapped(sender: AnyObject) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let blueViewNavgationController =   storyboard.instantiateViewControllerWithIdentifier("PhysciansViewControllerNavigation") as! BlueNavBarNavigationController
        let physciansViewController = blueViewNavgationController.topViewController as? PhysciansViewController
        physciansViewController!.delegate = self
        physciansViewController!.user = user
        presentViewController(blueViewNavgationController, animated: true, completion: nil)
    }
    
    func updatePhysician(physician: Physician) {
        user.selectedPhysician = physician
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let physician = user.selectedPhysician {
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let phsyicianCell = tableView.dequeueReusableCellWithIdentifier("PhysicianCell") as! PhysicianCell
        phsyicianCell.nameLabel.text = user.selectedPhysician!.name
        phsyicianCell.specialityLabel.text = user.selectedPhysician!.specialisedIN
        phsyicianCell.address.text = user.selectedPhysician!.address1
        phsyicianCell.addressLabel2.text = user.selectedPhysician!.address3
        phsyicianCell.profileImageView.image = user.selectedPhysician?.profilePic
        return phsyicianCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func backButton_Tapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let appointmentViewController = segue.destinationViewController as! AppointmentTypeViewController
        appointmentViewController.user = user
        
    }

    func setUpMapView() {
        let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
        mapView.layer.cornerRadius = 3.0
    }


}