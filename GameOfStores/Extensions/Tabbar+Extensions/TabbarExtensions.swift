//
//  TabbarExtensions.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation
import UIKit

// MARK: - Tabbar Setup Extensions

extension GameTabBarController: UITabBarControllerDelegate {
    
    func setUpTabBar() {
        self.tabBar.tintColor = .systemIndigo
        self.tabBar.backgroundColor = .systemGray5
        navigationItem.titleView?.isHidden = true
        navigationItem.hidesBackButton = true
        let VC1 = UINavigationController(rootViewController: GameHomeController())
        let VC2 = UINavigationController(rootViewController: GameFavoritesController())
        self.setViewControllers([VC1, VC2], animated: true)
        guard let item = self.tabBar.items else { return }
        item[0].image = UIImage(systemName: "house.fill")
        item[1].image = UIImage(systemName: "heart.fill")
        
    }
}
