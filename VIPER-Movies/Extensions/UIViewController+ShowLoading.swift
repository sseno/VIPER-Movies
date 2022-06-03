//
//  UIViewController+ShowLoading.swift
//  VIPER-Movies
//
//  Created by Seno on 03/06/22.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showLoadingHUD(_ loadingText: String? = nil, withBlockingUI defaultMaskType: SVProgressHUDMaskType = .none) {
        if let loadingMessage = loadingText {
            SVProgressHUD.show(withStatus: loadingMessage)
        } else {
            defaultLoadingHUD(defaultMaskType)
        }
    }

    private func defaultLoadingHUD(_ defaultMaskType: SVProgressHUDMaskType = .clear) {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setBackgroundColor(.init(white: 24/255, alpha: 0.8)) // HUD bg color
        SVProgressHUD.setForegroundColor(.white) // HUD indicator color
        SVProgressHUD.setDefaultMaskType(defaultMaskType) // HUD ui blocking color, default is .none, .clear for disable ui interaction
        SVProgressHUD.show()
    }

    func hideLoadingHUD() {
        SVProgressHUD.dismiss()
    }
}
