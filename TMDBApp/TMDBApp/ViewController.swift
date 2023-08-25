//
//  ViewController.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/08/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    

}


class ViewControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "bookmark.fill"), tag: 0)
        
        let secondVC = ViewControllerB()
        secondVC.tabBarItem = UITabBarItem(title: "TV", image: UIImage(systemName: "tv"), tag: 1)

        viewControllers = [firstVC, secondVC]
    }
}
