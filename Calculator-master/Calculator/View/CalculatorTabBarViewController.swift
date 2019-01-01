//
//  CalculatorTabBarViewController.swift
//  Calculator
//

import UIKit


class CalculatorTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = SciCalc()
        
        firstViewController.tabBarItem = UITabBarItem(title: "Calculator 1", image: UIImage(named: "image1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , tag: 1)
        
        let secondViewController = SciCalc()
        // BMIViewController()
        
        secondViewController.tabBarItem = UITabBarItem(title: "Calculator 2", image: UIImage(named: "image1")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) , tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]
        
        viewControllers = tabBarList
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
