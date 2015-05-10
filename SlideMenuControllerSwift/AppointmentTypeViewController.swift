//
//  AppointmentTypeViewController.swift
//  Empower
//
//  Created by Muralitharan on 08/05/15.
//  Copyright (c) 2015 Emids. All rights reserved.
//

import Foundation
import UIKit

class AppointmentTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, PickerViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var user: User!
    var weekDays:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    @IBOutlet weak var typeTextField: UITextField!
    var rowsCount: Int = 0
    var isAppointmentTypeSelected:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self.view, action: "endEditing:")
        gestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gestureRecognizer)
        navigationItem.title = "Schedule Appointment"
        isAppointmentTypeSelected = count(self.user.selectedAppointmentType) > 0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.isAppointmentTypeSelected! ? 4 : 1
        } else {
            return weekDays.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        
        case 0 where indexPath.row == 1:
            let switchCell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
            return switchCell
            
        case 0 where indexPath.row == 2 || indexPath.row == 0:
        let pickerViewCell = tableView.dequeueReusableCellWithIdentifier("PickerViewCell") as! PickerViewCell
        pickerViewCell.user = user
        pickerViewCell.titleLabel.text = indexPath.row == 2 ? "How may we contact you" : "Appointment Type"
        pickerViewCell.tag = indexPath.row
        pickerViewCell.delegate = self
        return pickerViewCell
            
        case 0 where indexPath.row == 3:
        let textViewCell = tableView.dequeueReusableCellWithIdentifier("TextViewCell") as! TextViewCell
        textViewCell.textView.delegate = self
        return textViewCell
    
        default:
        let dateCell = tableView.dequeueReusableCellWithIdentifier("DateCell") as! DateCell
        dateCell.dayLabel.text = weekDays[indexPath.row]
        return dateCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            if indexPath.row == 3 {
                return 112
            }
             return indexPath.row != 1 ? 80 : 120
        } else {
            return 70
        }
    }
    
    @IBAction func backButton_Tapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func typeSelected() {
        isAppointmentTypeSelected = true
        tableView.reloadData()
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0), atScrollPosition: .Middle, animated: true)
        return true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        headerView.backgroundColor = UIColor.whiteColor()
        let headingLabel = UILabel(frame: CGRectMake(20, 20, self.view.frame.width, 30))
        headingLabel.textColor = UIColor.blueColor()
        headingLabel.text = section == 0 ? "Appointment type" : "Preference Date/Time"
        headerView.addSubview(headingLabel)
        return headerView
    }
    
}

class DateCell: UITableViewCell {

    @IBOutlet weak var eveningButton: UIButton!
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
}

class SwitchCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var switchView2: UISwitch!
    @IBOutlet weak var switchView1: UISwitch!
    @IBOutlet weak var titleLabel2: UILabel!

    var user:User!
    
    func fillData() {
//       titleLabel1.text = ""
//       titleLabel2.text = ""
    }
}

class TextViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.layer.cornerRadius = 3.0
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth = 0.5
    }
}

protocol PickerViewCellDelegate: class {
    func typeSelected()
}

class PickerViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: PickerViewCellDelegate!
    var user: User!
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tag == 0 ? user.appointmentTypes.count : user.modeOfcontacts.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return tag == 0 ? user.appointmentTypes[row] : user.modeOfcontacts[row]
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.inputView = pickerView
        return true
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (tag == 0) {
          
        textField.text = user.appointmentTypes[row]
            if (count(user.selectedAppointmentType) == 0) {
                user.selectedAppointmentType = textField.text
                delegate.typeSelected()
            }
        user.selectedAppointmentType = textField.text
        } else {
            textField.text = user.modeOfcontacts[row]
            user.selectedAppointmentType = textField.text
        }
    }
}
