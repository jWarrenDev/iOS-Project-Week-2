//
//  AppDelegate.swift
//  Calculator
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Mark: - Regular View controller
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = CalculatorVC()
//        window?.makeKeyAndVisible()
//
//        return true
//    }
    
    // MARK: - Embed in Navigation controller
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.rootViewController = UINavigationController(rootViewController: CalculatorVC())
//
//
//        Appearance.customAppearance()
//        return true
//    }
//

    // MARK: Embed in TabBar Controller
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.rootViewController =
//
//        let tabBarController = UITabBarController()
//
//        let favoritesVC = UIViewController()
//        favoritesVC.title = "TestPage1"
//        favoritesVC.view.backgroundColor = UIColor.orange
//        let downloadsVC = UIViewController()
//        downloadsVC.title = "TestPage2"
//        downloadsVC.view.backgroundColor = UIColor.blue
//        let calculatorVC = CalculatorVC()
//
//        let controllers = [favoritesVC, downloadsVC, calculatorVC]
//        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
//
//
//
//        Appearance.customAppearance()
//        return true
//    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CalculatorTabBarViewController())
        window?.makeKeyAndVisible()
        Appearance.customAppearance()
        return true
    
    }
}

