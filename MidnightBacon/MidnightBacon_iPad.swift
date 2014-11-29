//
//  MidnightBacon_iPad.swift
//  MidnightBacon
//
//  Created by Justin Kolb on 11/26/14.
//  Copyright (c) 2014 Justin Kolb. All rights reserved.
//

import UIKit

class MidnightBacon_iPad : NSObject, MidnightBacon {
    var services: Services!
    var window: UIWindow!
    var splitViewController: UISplitViewController!
    var masterNavigationController: UINavigationController!
    var detailNavigationController: UINavigationController!
    var mainMenuViewController: UIViewController!
    var linksViewController: UIViewController!
    
    override init() {
        super.init()
    }
    
    func start() {
        services = MainServices()
        services.style.configureGlobalAppearance()
        setupInitialViewControllers()
        window = services.style.createMainWindow()
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()
    }
    
    func setupInitialViewControllers() {
        mainMenuViewController = createMainMenuViewController()
        linksViewController = createLinksViewController()
        masterNavigationController = createNavigationController(root: mainMenuViewController)
        detailNavigationController = createNavigationController(root: linksViewController)
        splitViewController = createSplitViewController(master: masterNavigationController, detail: detailNavigationController)
    }
    
    func createMainMenuViewController() -> UIViewController {
        let viewController = UITableViewController()
        viewController.title = "Menu"
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.configure(self, action: Selector("configureAction"))
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.messages(self, action: Selector("messagesAction"))
        return viewController
    }
    
    func createLinksViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Front"
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.sort(self, action: Selector("sortAction"))
        return viewController
    }
    
    func createNavigationController(# root: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        return navigationController
    }
    
    func createSplitViewController(# master: UIViewController, detail: UIViewController) -> UISplitViewController {
        let splitViewController = UISplitViewController(master: master, detail: detail)
        return splitViewController
    }
    
    func configureAction() {
    }
    
    func sortAction() {
    }
    
    func messagesAction() {
    }
}
