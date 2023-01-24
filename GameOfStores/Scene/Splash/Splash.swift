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

// MARK: - Network Control
extension Splash {
    
    func isNetwork() {
        if Connect.isConnected() {
            let viewController = GameTabBarController()
            viewController.modalPresentationStyle = .fullScreen
            self.show(viewController, sender: nil)
        } else {
            let errorAlert = UIAlertController(title: SplashConstant.SplashNetwork.alertTitle.rawValue, message: SplashConstant.SplashNetwork.alertMessage.rawValue,preferredStyle: .alert)
            let errorAction = UIAlertAction(title: SplashConstant.SplashNetwork.actionTitle.rawValue,style: .cancel)
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true)
        }
    }
}

// MARK: - View Functions
extension Splash {
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(logoAnimationView.logoGifImageView)
        drawDesign()
        logoAnimationView.logoGifImageView.delegate = self
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    private func drawDesign() {
        logoAnimationView.logoGifImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.unsafelyUnwrapped)
            make.height.equalTo(view.unsafelyUnwrapped)
        }
    }
    
    private func animation() {
        UIView.animate(withDuration: 3.2, animations: {
            self.logoAnimationView.logoGifImageView.alpha = 3.2
        }, completion: { _ in
            self.isNetwork()
        })
    }
}

extension Splash: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}

