//
//  Splash.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import UIKit
import SwiftyGif
import Alamofire
import SnapKit

// MARK: - Network Control
final class Connect {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// MARK: - Splash Screen & Swifty Gif
final class Splash: UIViewController {

    let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation()
    }
}
