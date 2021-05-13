//
//  DateFormatter.swift
//  Continuum
//
//  Created by Bryson Jones on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation

extension Date {
    func stringWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
