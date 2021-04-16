//
//  Date extension.swift
//  DmitriHomework
//
//  Created by Ruben Nahatakyan on 16.04.21.
//

import Foundation

extension Date {
    func string(format: String? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format ?? "d MMM yyyy HH:mm"
        return formatter.string(from: self)
    }
}
