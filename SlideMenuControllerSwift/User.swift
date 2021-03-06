//
//  User.swift
//  Empower
//
//  Created by Muralitharan on 07/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class User {
    
    var patients:[String] = []
    var selectedPatient:String = ""
   
    var physicians:[Physician] = []
    var selectedPhysician:Physician?
    
    var appointmentTypes:[String] = []
    var selectedAppointmentType:String = ""
    var preferredDateAndTime:[String:Int]?
    var modeOfcontacts:[String] = []
    var selectedModeOfContact:String = ""
    
    var appointments:[Appointment] = []
}

class Physician {
    
    var name:String = ""
    var specialisedIN:String = ""
    var profilePic:UIImage?
    var address1:String = ""
    var address2:String = ""
    var address3:String = ""
    
    var location:CLLocationCoordinate2D!
    var annotationTitle:String!
    var annotationSubTitle:String!
}


class Appointment {
    var physician: String = ""
    var time: String = ""
    var date: String = ""
    var month: String = ""
    var priorityColor: UIColor = UIColor()
    var status: String = ""
    var isFamily: Bool = true
    var personName: String = ""
    var visitType: String = ""
    var location: String = ""
    
}