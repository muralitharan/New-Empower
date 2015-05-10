//
//  HomeViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Dharani on 5/7/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPageViewControllerDelegate {

    lazy private var statsPageViewController: StatsPageViewController = self.childViewControllers.first as! StatsPageViewController
    
    @IBOutlet private weak var pageControl: UIPageControl!
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsPageViewController.configure(["My Appointments", "My Patients", "My Doctors"], delegate: self)
        pageControl.numberOfPages = 4
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func setViewControllerAtIndex(newIndex: Int) {
//        let singleStatViewController = StatsPageViewController.viewControllerAtIndex(newIndex)
//        
//        if statsPageViewController.viewControllers.isEmpty {
//            statsPageViewController.setViewControllers([singleStatViewController])
//        } else {
//            let direction: UIPageViewControllerNavigationDirection = newIndex < healthStatsPageViewController.currentPageIndex ? .Reverse : .Forward
//            healthStatsPageViewController.setViewControllers([healthStatViewController], direction:direction, animated: true)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
