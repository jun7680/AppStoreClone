//
//  Int+.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/22.
//

import Foundation

extension Int {
    var userCountingFormat: String {
        if self >= 1000, self <= 9999 {
            return String(format: "%.1f천", locale: Locale.current, round(Double(self) / 10) / 100).replacingOccurrences(of: ".0", with: "")
        }
        if self >= 10000, self <= 99999 {
            print("number", round(Double(10516)/1000) / 10, 10516 / 1000)
            return String(format: "%.1f만", locale: Locale.current, round(Double(self) / 1000) / 10).replacingOccurrences(of: ".0", with: "")
        }
        
        if self >= 100000 {
            return String(format: "%d만", locale: Locale.current, Int(round(Double(self) / 10000))).replacingOccurrences(of: ".0", with: "")
        }
        
        
        return String(format: "%d",locale: Locale.current, self)
    }
}
