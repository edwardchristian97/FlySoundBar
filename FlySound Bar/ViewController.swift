//
//  ViewController.swift
//  FlySound Bar
//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRevealingSplashView()
    }
}

// MARK: UI Setup
extension ViewController {

    private func setupRevealingSplashView() {
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "AppLogo")!,
                                                      iconInitialSize: CGSize(width: 414, height: 896),
                                                      backgroundColor: .black)
        view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
    }
}
