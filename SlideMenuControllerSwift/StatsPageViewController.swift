//
//  StatsPageViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Dharani on 5/7/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

class StatsPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    private var stats: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
    }
    
    func configure(myStrings:[String], delegate: UIPageViewControllerDelegate) {
        self.stats = myStrings
        self.delegate = delegate
    }
    
    var numberOfPages: Int {
        return stats.count
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = 3
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = 2
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> SingleStatViewController? {
        if index < 0 || index >= 3 {
            return nil
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let singleStatViewController = storyBoard.instantiateViewControllerWithIdentifier("SingleStatViewController") as! SingleStatViewController
        return singleStatViewController
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
