//
//  UIViewControllerExtension.swift
//  Continuum
//
//  Created by Bryson Jones on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentSimpleAlertWith(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
