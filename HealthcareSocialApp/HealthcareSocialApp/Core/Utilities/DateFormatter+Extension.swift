//
//  DateFormatter+Extension.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import Foundation

extension DateFormatter {

    static let mediumDate: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
}

extension Int {

    var formattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return DateFormatter.mediumDate.string(from: date)
    }

    var asDate: Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }

    var asAudioDuration: String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Double {
    var asAudioDuration: String {
        let totalSeconds = Int(self)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
