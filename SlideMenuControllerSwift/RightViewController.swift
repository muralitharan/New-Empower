//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import MapKit

class RightViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = fillData()
        navigationItem.title = "Schedule Appointment"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBtn_Tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func fillData() -> User {
        
        let user = User()
        user.patients = ["Smith John","Dyer Jessica", "Ross Jolena", "Rees Karen"]
        user.selectedPatient = user.patients[0]
        user.modeOfcontacts = ["Patient Portal", "Call", "Text", "Email"]
        
        let physician1 = Physician()
        physician1.name = "Kevin Brune"
        physician1.specialisedIN = "Dentist"
        physician1.profilePic = UIImage(named: "Doc_Image.jpg")
        physician1.address1 = "489, 5th Ave"
        physician1.address2 = "4th Floor"
        physician1.address3 = "New York, NY 10017"
        physician1.location = CLLocationCoordinate2D(
            latitude: 40.7350235,
            longitude: -73.9876265
        )
        physician1.annotationTitle = "One Medical Group"
        physician1.annotationSubTitle = "Health care for the whole person"

        
        
        let physician2 = Physician()
        physician2.name = "Davies Jan"
        physician2.specialisedIN = "Primary Care"
        physician2.profilePic = UIImage(named: "third.jpeg")
        physician2.address1 = "48 Madison AVE #1220"
        physician2.address2 = "45th Floor"
        physician2.address3 = "New York, NY 10022"
        physician2.location = CLLocationCoordinate2D(
            latitude: 40.7600163,
            longitude: -73.972506
        )
        physician2.annotationTitle = "St Lukes Roosevelt Hospital Center"
        physician2.annotationSubTitle = "School of medicine"
        
        
        let physician3 = Physician()
        physician3.name = "Clark Gabrielle"
        physician3.specialisedIN = "Dermatology"
        physician3.profilePic = UIImage(named: "second.jpeg")
        physician3.address1 = "200 W 20th ST #105"
        physician3.address2 = "5th Floor"
        physician3.address3 = "New York, NY 10011"
        physician3.location = CLLocationCoordinate2D(
            latitude: 40.741664,
            longitude: -73.986432
        )
        
        physician3.annotationTitle = "Dr. Ovatish"
        physician3.annotationSubTitle = "School of medicine"
        
        let physician4 = Physician()
        physician4.name = "Allan Kinser"
        physician4.specialisedIN = "Dermatology"
        physician4.profilePic = UIImage(named: "allan_kisner.jpeg")
        physician4.address1 = "301 Park Ave #100"
        physician4.address2 = "5th Floor"
        physician4.address3 = "New York, NY 10022"
        physician4.location = CLLocationCoordinate2D(
            latitude: 40.7565711,
            longitude: -73.9736422
        )
        
        physician4.annotationTitle = "Kisner Plastic Surgery Center"
        physician4.annotationSubTitle = "School of medicine"
        
        let physician5 = Physician()
        physician5.name = "Fione J Watson"
        physician5.specialisedIN = "Dental"
        physician5.profilePic = UIImage(named: "fione_watson.jpg")
        physician5.address1 = "224 W 35th Street"
        physician5.address2 = "5th Floor"
        physician5.address3 = "New York, NY 10001"
        physician5.location = CLLocationCoordinate2D(
            latitude: 40.7529769,
            longitude: -73.9958918
        )
        
        physician5.annotationTitle = "Herald Square Dental"
        physician5.annotationSubTitle = ""
        
        user.physicians = [physician1,physician2,physician3,physician4,physician5]
        user.appointmentTypes = ["Follow-up Visit", "Annual Physical", "Lab Work", "Cardiology Check-up"]
        
        let appointment1 = Appointment()
        appointment1.physician = physician3.name
        appointment1.time = "10:30 AM"
        appointment1.date = "20"
        appointment1.month = "JAN"
        appointment1.priorityColor = UIColor(red: 76/255, green: 153/255, blue: 0/255, alpha: 1.0)
        appointment1.status = "confirmed"
        appointment1.isFamily = false
        
        let appointment2 = Appointment()
        appointment2.physician = physician1.name
        appointment2.time = "05:30 PM"
        appointment2.date = "12"
        appointment2.month = "NOV"
        appointment2.priorityColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1.0)
        appointment2.status = "pending"
        appointment2.isFamily = true
        appointment2.personName = "Edmunds Joan"
        
        let appointment3 = Appointment()
        appointment3.physician = physician2.name
        appointment3.time = "09:30 AM"
        appointment3.date = "02"
        appointment3.month = "SEP"
        appointment3.priorityColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1.0)
        appointment3.status = "cancelled"
        appointment3.isFamily = true
        appointment3.personName = "Dyer Jessica"
        
        let appointment4 = Appointment()
        appointment4.physician = physician3.name
        appointment4.time = "12:30 PM"
        appointment4.date = "12"
        appointment4.month = "AUG"
        appointment4.priorityColor = UIColor(red: 76/255, green: 153/255, blue: 0/255, alpha: 1.0)
        appointment4.status = "confirmed"
        appointment4.isFamily = false
        
        let appointment5 = Appointment()
        appointment5.physician = physician2.name
        appointment5.time = "05:30 PM"
        appointment5.date = "13"
        appointment5.month = "MAR"
        appointment5.priorityColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1.0)
        appointment5.status = "cancelled"
        appointment5.isFamily = true
        appointment5.personName = "Davidson Irene"
        
        let appointment6 = Appointment()
        appointment6.physician = physician3.name
        appointment6.time = "11:30 AM"
        appointment6.date = "31"
        appointment6.month = "MAR"
        appointment6.priorityColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1.0)
        appointment6.status = "pending"
        appointment6.isFamily = false

        let appointment7 = Appointment()
        appointment7.physician = physician2.name
        appointment7.time = "01:30 PM"
        appointment7.date = "28"
        appointment7.month = "FEB"
        appointment7.priorityColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1.0)
        appointment7.status = "pending"
        appointment7.isFamily = false
        
        user.appointments = [appointment1, appointment2, appointment3, appointment4, appointment5, appointment6, appointment7]
        
        return user
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.patients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .None
        cell?.textLabel?.text = user.patients[indexPath.row]
        cell?.textLabel?.font =  UIFont (name: "Lato", size: 18)
        cell?.textLabel?.textColor = UIColor(red: 143/255.0, green: 144/255.0, blue: 145/255.0, alpha: 1)
        cell?.accessoryType = find(user.patients, user.selectedPatient) == indexPath.row ? .Checkmark : .None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let previousSelectedCell:UITableViewCell! = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: find(user.patients, user.selectedPatient)!, inSection: 0))
        previousSelectedCell.accessoryType = .None
        
        let cell: UITableViewCell! = tableView.cellForRowAtIndexPath(indexPath)
        cell.accessoryType = .Checkmark
        user.selectedPatient = user.patients[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let physiciansViewController = segue.destinationViewController as! PhysciansViewController
        physiciansViewController.user = user
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        roundViewCorners(self)
    }
}

private func roundViewCorners(view: UIView) {
    view.layer.cornerRadius = view.bounds.height / 2
    view.layer.masksToBounds = true
}

class RoundedButtonWithChevron: RoundedButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let chevronImage = UIImage(named: "navigateright-small")!.imageWithRenderingMode(.AlwaysTemplate)
        setImage(chevronImage, forState: .Normal)
        imageEdgeInsets = UIEdgeInsetsMake(0, bounds.width - 20, 0, 0)
        titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
    }
}

import UIKit

/**
As its name implies, this class is used in storyboard where the nav bar should be blue.
*/
class BlueNavBarNavigationController: BaseNavigationController {
    
    override func assertAppearenceAndFontIsSetCorrectly() {
        super.assertAppearenceAndFontIsSetCorrectly()
        
        // assert(navigationBar.barTintColor! == Colors.navigationBarBlueColor(), "Storyboard color should be set to \(Colors.navigationBarBlueColor().debugDescription)")
        
        // Font should be TrebuchetMS 16.0
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lato", size: 16)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        let titleTextAttributes = navigationBar.titleTextAttributes!
        let font = titleTextAttributes[NSFontAttributeName]! as! UIFont
        // assert(font.fontName == "HelveticaNeue", "Font is incorrectly set to \(font.fontName)")
        // assert(font.pointSize == 16.0, "Font size is incorrectly set to \(font.pointSize)")
        
        // Font color should be white
        let color = titleTextAttributes[NSForegroundColorAttributeName]! as! UIColor
        assert(color == UIColor.whiteColor(), "Font color is incorrectly set to \(color.debugDescription)")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        assertAppearenceAndFontIsSetCorrectly()
    }
    
    func assertAppearenceAndFontIsSetCorrectly() {
        assert(navigationBar.translucent)
    }
}

@objc class Colors {
    class func navigationBarBlueColor() -> UIColor {
        return RGB(90, 184, 221)
    }
    
    class func blueBackground() -> UIColor {
        return RGB(213, 234, 244)
    }
    
    class func notificationInfoColor() -> UIColor {
        return RGB(24, 138, 182)
    }
    
    class func notificationErrorColor() -> UIColor {
        return UIColor.redColor()
    }
    
    class func selectedResponseButtonColor() -> UIColor {
        return RGB(22, 96, 152)
    }
    
    
}

private func RGB(r: Int, g: Int, b: Int) -> UIColor {
    return RGBA(r, g, b, 1.0)
}

private func RGBA(r: Int, g: Int, b: Int, a: CGFloat) -> UIColor {
    return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
}

class LabelTitle: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "Lato", size: 18.0)
        self.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.6)
    }
}

class LabelValue: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "Lato", size: 18.0)
        self.textColor = UIColor(red: 143/255.0, green: 144/255.0, blue: 145/255.0, alpha: 1)
    }
}

class LabelAddress: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "Lato", size: 12.0)
        self.textColor = UIColor(red: 143/255.0, green: 144/255.0, blue: 145/255.0, alpha: 1)
    }
}

class LabelHeading: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "Lato", size: 22.0)
        self.textColor = UIColor(red: 83.0/255.0, green: 182.0/255.0, blue: 230.0/255.0, alpha: 1)
    }
}

