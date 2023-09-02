//
//  TabBarController.swift
//  TMDBApp
//
//  Created by hyeonseok on 2023/08/26.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieVC = MovieListViewController()
        movieVC.tabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "bookmark.fill"), tag: 0)
        
        let tvVC = TVListViewController()
        tvVC.tabBarItem = UITabBarItem(title: "TV", image: UIImage(systemName: "tv"), tag: 1)

        viewControllers = [movieVC, tvVC]
    }
}
