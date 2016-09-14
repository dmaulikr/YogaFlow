//
//  FlowDetailPosesPageViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 9/14/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class FlowDetailPosesPageViewController: UIPageViewController {
    
    var flow: Flow?
    var pose: Pose?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let flow = flow, let pose = pose {
            print(flow.name)
            print(pose.name)
        }
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    var orderedViewControllers: [UIViewController] {
        var detailViewControllers: [UIViewController] = []
        
        if let flow = flow {
            for pose in flow.poses {
                let poseDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PoseDetailVC") as? PoseDetailViewController
                poseDetailVC?.pose = pose as? Pose
                detailViewControllers.append(poseDetailVC!)
            }
        }
//        
//        if let pose = pose, let poseDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PoseDetailVC") as? PoseDetailViewController {
//            poseDetailVC.pose = pose
//            return [poseDetailVC]
//        } else {
//            return []
//        }
        return detailViewControllers
    }
    
}

extension FlowDetailPosesPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
}