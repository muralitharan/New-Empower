//
//  SlideMenuController.swift
//
//  Created by Yuji Hato on 12/3/14.
//

import Foundation
import UIKit


class SlideMenuOption {
    
    var leftViewWidth: CGFloat = 240.0
    var leftBezelWidth: CGFloat = 16.0
    var contentViewScale: CGFloat = 0.96
    var contentViewOpacity: CGFloat = 0.5
    var shadowOpacity: CGFloat = 0.0
    var shadowRadius: CGFloat = 0.0
    var shadowOffset: CGSize = CGSizeMake(0,0)
    var panFromBezel: Bool = true
    var animationDuration: CGFloat = 0.4
    var rightViewWidth: CGFloat = 270.0
    var rightBezelWidth: CGFloat = 16.0
    var rightPanFromBezel: Bool = true
    var hideStatusBar: Bool = true
    var pointOfNoReturnWidth: CGFloat = 44.0
    
    init() {
        
    }
}


class SlideMenuController: UIViewController, UIGestureRecognizerDelegate {

    enum SlideAction {
        case Open
        case Close
    }
    
    enum TrackAction {
        case TapOpen
        case TapClose
        case FlickOpen
        case FlickClose
    }
    
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    var opacityView = UIView()
    var homeContainerView = UIView()
    var leftContainerView = UIView()
    var homeViewController: UIViewController?
    var leftViewController: UIViewController?
    var leftPanGesture: UIPanGestureRecognizer?
    var leftTapGetsture: UITapGestureRecognizer?
    var rightTapGesture: UITapGestureRecognizer?
    var options = SlideMenuOption()

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(homeViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()
        self.homeViewController = homeViewController
        self.leftViewController = leftMenuViewController
        self.initView()
    }
    
    convenience init(homeViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.homeViewController = homeViewController
        self.initView()
    }
    
    convenience init(homeViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.homeViewController = homeViewController
        self.leftViewController = leftMenuViewController
        self.initView()
    }
    
    deinit { }
    
    func initView() {
        homeContainerView = UIView(frame: self.view.bounds)
        homeContainerView.backgroundColor = UIColor.clearColor()
        homeContainerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.view.insertSubview(homeContainerView, atIndex: 0)

        var opacityframe: CGRect = self.view.bounds
        var opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.blackColor()
        opacityView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        opacityView.layer.opacity = 0.0
        self.view.insertSubview(opacityView, atIndex: 1)
        
        var leftFrame: CGRect = self.view.bounds
        leftFrame.size.width = self.options.leftViewWidth
        leftFrame.origin.x = self.leftMinOrigin();
        var leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView = UIView(frame: leftFrame)
        leftContainerView.backgroundColor = UIColor.clearColor()
        leftContainerView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.insertSubview(leftContainerView, atIndex: 2)
        
        self.addLeftGestures()
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        
        self.homeContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.leftContainerView.hidden = true
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        
        self.closeLeftNonAnimation()
        self.leftContainerView.hidden = false

        self.removeLeftGestures()
        self.addLeftGestures()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillLayoutSubviews() {
        // topLayoutGuideの値が確定するこのタイミングで各種ViewControllerをセットする
        self.setUpViewController(self.homeContainerView, targetViewController: self.homeViewController)
        self.setUpViewController(self.leftContainerView, targetViewController: self.leftViewController)
    }
    
    override func openLeft() {
        self.setOpenWindowLevel()
        
        //leftViewControllerのviewWillAppearを呼ぶため
        self.leftViewController?.beginAppearanceTransition(self.isLeftHidden(), animated: true)
        self.openLeftWithVelocity(0.0)
        
        self.track(.TapOpen)
    }
    
    override func closeLeft() {
        self.leftViewController?.beginAppearanceTransition(self.isLeftHidden(), animated: true)
        self.closeLeftWithVelocity(0.0)
        self.setCloseWindowLebel()
    }
    
    
    func addLeftGestures() {
    
        if (self.leftViewController != nil) {
            if self.leftPanGesture == nil {
                self.leftPanGesture = UIPanGestureRecognizer(target: self, action: "handleLeftPanGesture:")
                self.leftPanGesture!.delegate = self
                self.view.addGestureRecognizer(self.leftPanGesture!)
            }
            
            if self.leftTapGetsture == nil {
                self.leftTapGetsture = UITapGestureRecognizer(target: self, action: "toggleLeft")
                self.leftTapGetsture!.delegate = self
                self.view.addGestureRecognizer(self.leftTapGetsture!)
            }
        }
    }
    
    func removeLeftGestures() {
        
        if self.leftPanGesture != nil {
            self.view.removeGestureRecognizer(self.leftPanGesture!)
            self.leftPanGesture = nil
        }
        
        if self.leftTapGetsture != nil {
            self.view.removeGestureRecognizer(self.leftTapGetsture!)
            self.leftTapGetsture = nil
        }
    }
    
   
    func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    func track(trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    struct LeftPanState {
        static var frameAtStartOfPan: CGRect = CGRectZero
        static var startPointOfPan: CGPoint = CGPointZero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handleLeftPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if !self.isTagetViewController() {
            return
        }
        
        switch panGesture.state {
            case UIGestureRecognizerState.Began:
                
                LeftPanState.frameAtStartOfPan = self.leftContainerView.frame
                LeftPanState.startPointOfPan = panGesture.locationInView(self.view)
                LeftPanState.wasOpenAtStartOfPan = self.isLeftOpen()
                LeftPanState.wasHiddenAtStartOfPan = self.isLeftHidden()
                
                self.leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
                self.addShadowToView(self.leftContainerView)
                self.setOpenWindowLevel()
            case UIGestureRecognizerState.Changed:
                
                var translation: CGPoint = panGesture.translationInView(panGesture.view!)
                self.leftContainerView.frame = self.applyLeftTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
                self.applyLeftOpacity()
                self.applyLeftContentViewScale()
            case UIGestureRecognizerState.Ended:
                
                var velocity:CGPoint = panGesture.velocityInView(panGesture.view)
                var panInfo: PanInfo = self.panLeftResultInfoForVelocity(velocity)
                
                if panInfo.action == .Open {
                    if !LeftPanState.wasHiddenAtStartOfPan {
                        self.leftViewController?.beginAppearanceTransition(true, animated: true)
                    }
                    self.openLeftWithVelocity(panInfo.velocity)
                    self.track(.FlickOpen)
                    
                } else {
                    if LeftPanState.wasHiddenAtStartOfPan {
                        self.leftViewController?.beginAppearanceTransition(false, animated: true)
                    }
                    self.closeLeftWithVelocity(panInfo.velocity)
                    self.setCloseWindowLebel()
                    
                    self.track(.FlickClose)

                }
        default:
            break
        }
        
    }
    
    func openLeftWithVelocity(velocity: CGFloat) {
        var xOrigin: CGFloat = self.leftContainerView.frame.origin.x
        var finalXOrigin: CGFloat = 0.0
        
        var frame = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin;
        
        var duration: NSTimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.addShadowToView(self.leftContainerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.leftContainerView.frame = frame
            self.opacityView.layer.opacity = Float(self.options.contentViewOpacity)
            self.homeContainerView.transform = CGAffineTransformMakeScale(self.options.contentViewScale, self.options.contentViewScale)
        }) { (Bool) -> Void in
            self.disableContentInteraction()
            self.leftViewController?.endAppearanceTransition()
        }
    }
    
    func closeLeftWithVelocity(velocity: CGFloat) {
        
        var xOrigin: CGFloat = self.leftContainerView.frame.origin.x
        var finalXOrigin: CGFloat = self.leftMinOrigin()
        
        var frame: CGRect = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin
    
        var duration: NSTimeInterval = Double(self.options.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.leftContainerView.frame = frame
            self.opacityView.layer.opacity = 0.0
            self.homeContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (Bool) -> Void in
                self.removeShadow(self.leftContainerView)
                self.enableContentInteraction()
                self.leftViewController?.endAppearanceTransition()
        }
    }
    
    override func toggleLeft() {
        if self.isLeftOpen() {
            self.closeLeft()
            self.setCloseWindowLebel()
            // closeMenuはメニュータップ時にも呼ばれるため、closeタップのトラッキングはここに入れる
            
            self.track(.TapClose)
        } else {
            self.openLeft()
        }
    }
    
    func isLeftOpen() -> Bool {
        return self.leftContainerView.frame.origin.x == 0.0
    }
    
    func isLeftHidden() -> Bool {
        return self.leftContainerView.frame.origin.x <= self.leftMinOrigin()
    }
    
    func changeMainViewController(homeViewController: UIViewController,  close: Bool) {
        
        self.removeViewController(self.homeViewController)
        self.homeViewController = homeViewController
        self.setUpViewController(self.homeContainerView, targetViewController: self.homeViewController)
        if (close) {
            self.closeLeft()
        }
    }
    
    func changeLeftViewController(leftViewController: UIViewController, closeLeft:Bool) {
        
        self.removeViewController(self.leftViewController)
        self.leftViewController = leftViewController
        self.setUpViewController(self.leftContainerView, targetViewController: self.leftViewController)
        if (closeLeft) {
            self.closeLeft()
        }
    }
    
    private func leftMinOrigin() -> CGFloat {
        return  -self.options.leftViewWidth
    }
    
    private func panLeftResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        var thresholdVelocity: CGFloat = 1000.0
        var pointOfNoReturn: CGFloat = CGFloat(floor(self.leftMinOrigin())) + self.options.pointOfNoReturnWidth
        var leftOrigin: CGFloat = self.leftContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .Close : .Open;
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .Close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    private func applyLeftTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect {
        
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        var minOrigin: CGFloat = self.leftMinOrigin()
        var maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    private func getOpenedLeftRatio() -> CGFloat {
        
        var width: CGFloat = self.leftContainerView.frame.size.width
        var currentPosition: CGFloat = self.leftContainerView.frame.origin.x - self.leftMinOrigin()
        return currentPosition / width
    }
    
    private func applyLeftOpacity() {
        
        var openedLeftRatio: CGFloat = self.getOpenedLeftRatio()
        var opacity: CGFloat = self.options.contentViewOpacity * openedLeftRatio
        self.opacityView.layer.opacity = Float(opacity)
    }
    
    private func applyLeftContentViewScale() {
        var openedLeftRatio: CGFloat = self.getOpenedLeftRatio()
        var scale: CGFloat = 1.0 - ((1.0 - self.options.contentViewScale) * openedLeftRatio);
        self.homeContainerView.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    private func addShadowToView(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowOffset = self.options.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(self.options.shadowOpacity)
        targetContainerView.layer.shadowRadius = self.options.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).CGPath
    }
    
    private func removeShadow(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        self.homeContainerView.layer.opacity = 1.0
    }
    
    private func removeContentOpacity() {
        self.opacityView.layer.opacity = 0.0
    }
    

    private func addContentOpacity() {
        self.opacityView.layer.opacity = Float(self.options.contentViewOpacity)
    }
    
    private func disableContentInteraction() {
        self.homeContainerView.userInteractionEnabled = false
    }
    
    private func enableContentInteraction() {
        self.homeContainerView.userInteractionEnabled = true
    }
    
    private func setOpenWindowLevel() {
        if (self.options.hideStatusBar) {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelStatusBar + 1
                }
            })
        }
    }
    
    private func setCloseWindowLebel() {
        if (self.options.hideStatusBar) {
            dispatch_async(dispatch_get_main_queue(), {
                if let window = UIApplication.sharedApplication().keyWindow {
                    window.windowLevel = UIWindowLevelNormal
                }
            })
        }
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            self.addChildViewController(viewController)
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
    }
    
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMoveToParentViewController(nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    func closeLeftNonAnimation(){
        self.setCloseWindowLebel()
        var finalXOrigin: CGFloat = self.leftMinOrigin()
        var frame: CGRect = self.leftContainerView.frame;
        frame.origin.x = finalXOrigin
        self.leftContainerView.frame = frame
        self.opacityView.layer.opacity = 0.0
        self.homeContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.removeShadow(self.leftContainerView)
        self.enableContentInteraction()
    }
    
    
    //pragma mark – UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    
        var point: CGPoint = touch.locationInView(self.view)
        
        if gestureRecognizer == self.leftPanGesture {
            return self.slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        } else if gestureRecognizer == self.leftTapGetsture {
            return self.isLeftOpen() && !self.isPointContainedWithinLeftRect(point)
        }
        
        return true
    }
    
    private func slideLeftForGestureRecognizer( gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        return self.isLeftOpen() || self.options.panFromBezel && self.isLeftPointContainedWithinBezelRect(point)
    }
    
    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRectZero
        var tempRect: CGRect = CGRectZero
        var bezelWidth: CGFloat = self.options.leftBezelWidth
        
        CGRectDivide(self.view.bounds, &leftBezelRect, &tempRect, bezelWidth, CGRectEdge.MinXEdge)
        return CGRectContainsPoint(leftBezelRect, point)
    }
    
    private func isPointContainedWithinLeftRect(point: CGPoint) -> Bool {
        return CGRectContainsPoint(self.leftContainerView.frame, point)
    }
    
}


extension UIViewController {

    func slideMenuController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parentViewController
        }
        return nil;
    }
    
    func addLeftBarButtonWithImage(buttonImage: UIImage) {
        var leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Plain, target: self, action: "toggleLeft")
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    
    func addRightBarButtonWithImage(buttonImage: UIImage) {
        var rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Plain, target: self, action: "toggleRight")
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    func toggleLeft() {
        self.slideMenuController()?.toggleLeft()
    }

    func toggleRight() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let blueViewNavgationController =   storyboard!.instantiateViewControllerWithIdentifier("BlueNavBarNavigationController") as! BlueNavBarNavigationController
        let rightViewController = blueViewNavgationController.topViewController as? PhysciansViewController
        presentViewController(blueViewNavgationController, animated: true, completion: nil)
    }
    
    func openLeft() {
        self.slideMenuController()?.openLeft()
    }
    
    func closeLeft() {
        self.slideMenuController()?.closeLeft()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    func addPriorityToMenuGesuture(targetScrollView: UIScrollView) {
        if let slideControlelr = self.slideMenuController() {
            let recognizers =  slideControlelr.view.gestureRecognizers
            for recognizer in recognizers as! [UIGestureRecognizer] {
                if recognizer is UIPanGestureRecognizer {
                    targetScrollView.panGestureRecognizer.requireGestureRecognizerToFail(recognizer)
                }
            }
        }
    }
}
