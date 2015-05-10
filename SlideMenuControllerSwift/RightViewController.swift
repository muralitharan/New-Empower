//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

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
        physician1.name = "Ellison Joanne"
        physician1.specialisedIN = "Dentist"
        physician1.profilePic = UIImage(named: "Doc_Image.jpg")
        physician1.address1 = "185 Canel Street"
        physician1.address2 = "4th Floor"
        physician1.address3 = "New York, NY 10013"
        
        let physician2 = Physician()
        physician2.name = "Davies Jan"
        physician2.specialisedIN = "Primary Care"
        physician2.profilePic = UIImage(named: "third.jpeg")
        physician2.address1 = "30 Broad Street"
        physician2.address2 = "45th Floor"
        physician2.address3 = "New York, NY 10004"
        
        let physician3 = Physician()
        physician3.name = "Clark Gabrielle"
        physician3.specialisedIN = "Dermatology"
        physician3.profilePic = UIImage(named: "second.jpeg")
        physician3.address1 = "40 Wall Street"
        physician3.address2 = "5th Floor"
        physician3.address3 = "New York, NY 10005"
        
        user.physicians = [physician1,physician2,physician3]
        user.appointmentTypes = ["Follow-up Visit", "Annual Physical", "Lab Work", "Cardiology Check-up"]
        
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
        let appointmentPhysicianLocationViewController = segue.destinationViewController as! AppointmentPhysicianLocationViewController
        appointmentPhysicianLocationViewController.user = user
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

