//
//  DateExtension.swift
//  PastilleEnterprise
//
//  Created by macbook on 7/3/1397 AP.
//  Copyright © 1397 AP kasra. All rights reserved.
//

import Foundation
extension Date {
    func reomveTimeFrom() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
  func toMillis() -> Int64! {
    return Int64(self.timeIntervalSince1970 * 1000)
  }
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .init(identifier: "en_US")
    dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.ZZZZZ"
    var c = dateFormatter.string(from: self)
    if c == ""{
      dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.Z"
      c = dateFormatter.string(from: self)
      if c == "" {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        c = dateFormatter.string(from: self)
        if c == "" {
          dateFormatter.dateFormat = "yyyy-MM-dd'T'"
          c = dateFormatter.string(from: self)
        }
        if c == "" {
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
          c = dateFormatter.string(from: self)
        }
      }
    }
    return c
  }
  func toStringWithT() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS ZZZZZ"
    var c = dateFormatter.string(from: self)
    if c == ""{
      dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS"
      c = dateFormatter.string(from: self)
      if c == "" {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        c = dateFormatter.string(from: self)
        if c == "" {
          dateFormatter.dateFormat = "yyyy-MM-dd'T'"
          c = dateFormatter.string(from: self)
        }
      }
    }
    return c
  }
}

extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
