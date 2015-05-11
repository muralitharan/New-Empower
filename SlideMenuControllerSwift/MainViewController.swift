//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    var appointments: [Appointment]!
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightViewController = RightViewController.alloc()
        appointments = rightViewController.fillData().appointments
        tblView.estimatedRowHeight = 60
        tblView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Appointments"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    let appointmentCellExpansionDelegate = CellExpansionDelegate()
    
    // MARK: UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AppointmentCell") as! AppointmentCell
        cell.expanded = indexPath == appointmentCellExpansionDelegate.indexPathForExpandedRow
        cell.fillAppointmentsData(appointment: appointments[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        appointmentCellExpansionDelegate.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(10, 2, tableView.frame.size.width, 26))
        headerView.backgroundColor = UIColor(red: 204/255, green: 229/255, blue: 255/255, alpha: 1.0)
        let header = UILabel(frame: headerView.frame)
        header.text = ["2014", "2015"][section]
        header.font = UIFont(name: "Helvetica", size: 20)
        header.textColor = UIColor(red: 0/255, green: 204/255, blue: 204/255, alpha: 0.6)
        headerView.addSubview(header)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

}


class AppointmentCell: UITableViewCell {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var physician: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var visitType: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var sideView: UIView!
    
    var expanded: Bool = false {
        didSet {
            if expanded {
                heightConstraint.priority = 1
                visitType.hidden = false
                location.hidden = false
            } else {
                heightConstraint.priority = 999
                visitType.hidden = true
                location.hidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillAppointmentsData(#appointment: Appointment) {
        if appointment.isFamily {
            patientName.text = appointment.personName
        } else {
            patientName.text = "You"
        }
        physician.text = appointment.physician
        time.text = "Time: \(appointment.time)"
        date.text = appointment.date
        month.text = appointment.month
        status.text = appointment.status
        visitType.text = "Visit Type: \(appointment.visitType)"
        location.text = "Location: \(appointment.visitType)"
        sideView.backgroundColor = appointment.priorityColor
        date.textColor = appointment.priorityColor
        month.textColor = appointment.priorityColor
    }
    
}

