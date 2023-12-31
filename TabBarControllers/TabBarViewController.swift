//
//  ViewController.swift
//  Tracker
//
//  Created by Марат Хасанов on 27.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let tracker = createTabBar(title: "Трекеры", image: UIImage(named: "ic 28x28-2"), vc: TrackersViewController())
        let stats = createTabBar(title: "Статистика", image: UIImage(named: "ic 28x28"), vc: StatisticsViewController())
        setViewControllers([tracker, stats], animated: true)
    }
    
    private func createTabBar(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let setting = UINavigationController(rootViewController: vc)
        setting.navigationBar.prefersLargeTitles = true
        setting.tabBarItem.title = title
        setting.tabBarItem.image = image
        setting.viewControllers.first?.navigationItem.title = title
        return setting
    }
}


