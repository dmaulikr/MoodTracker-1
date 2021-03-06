//
//  DayStatistics.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public struct DayStatistics {
    public var moodValue: MoodValue

    public var moodValuePerHours: [Int: MoodValue]
    
    public init(moodValue: MoodValue, moodValuePerHours: [Int: MoodValue]) {
        self.moodValuePerHours = moodValuePerHours
        self.moodValue = moodValue
    }
    
    public init(moodStamps: [MoodStamp]) {
        
        var totalValues = [Double]()
        var valuesForHours = [Int: [Double]]()
        
        for stamp in moodStamps {
            totalValues.append(stamp.mood.rawValue)
            
            let hour = stamp.timestamp.hour
            var moodForHour = valuesForHours[hour] ?? [Double]()
            moodForHour.append(stamp.mood.rawValue)
            
            valuesForHours[hour] = moodForHour
        }
        
        var moodsForHours = [Int: MoodValue]()
        for (hour, values) in valuesForHours {
            moodsForHours[hour] = MoodValue(values: values)
        }
        
        self.init(moodValue: MoodValue(values: totalValues), moodValuePerHours: moodsForHours)
        
    }
    
}

extension Date {
    var hour: Int {
        return Calendar.current().component(.hour, from: self)
    }
}

public extension Day {
    public var statistics: DayStatistics {
        return DayStatistics(moodStamps: self.moodStamps)
    }
}
