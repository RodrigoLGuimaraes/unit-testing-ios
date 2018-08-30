//
//  Double+Utils.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 30/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
