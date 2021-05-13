//
//  PhotoSelectorViewControllerDelegate.swift
//  Continuum
//
//  Created by Bryson Jones on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate: AnyObject {
    func photoSelectorViewControllerSelected(image: UIImage)
}
