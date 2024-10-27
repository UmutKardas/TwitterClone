//
//  Date+Extension.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 27.10.2024.
//
import Foundation

extension Date {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
