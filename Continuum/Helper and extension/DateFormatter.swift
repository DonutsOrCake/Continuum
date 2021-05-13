//
//  DateFormatter.swift
//  Continuum
//
//  Created by Bryson Jones on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation
extension DateFormatter {
    static let currentTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}//End of extension
