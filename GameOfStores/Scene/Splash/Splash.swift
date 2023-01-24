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

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
