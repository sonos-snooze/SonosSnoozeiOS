//
//  AlarmAPI.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/9/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import Foundation
import Alamofire

public class AlarmAPI {
    
    static let apiUrl = "https://shrouded-scrubland-66108.herokuapp.com/api/"
    static let alarmsResource = "alarms"

    static func getAlarms(success: @escaping (_ alarms: [Alarm]) -> ()) {
        var alarms: [Alarm] = []
        
        Alamofire.request(apiUrl + alarmsResource).responseJSON { response in
            
            if let json = response.result.value as! NSArray? {
                for jsonObj in json {
                    
                    if let alarmJson = jsonObj as? NSDictionary {
                        let alarm = Alarm()
                        alarm.setup(alarmJson: alarmJson)
                        alarms.append(alarm)
                        
                    }
                }
            }
            
            success(alarms)
        }
    }
    
    static func makeAlarm(_ alarm: Alarm, success: @escaping (_ alarm: Alarm) -> ()) {
        let url = apiUrl + alarmsResource
        
        let parameters = alarm.toJson()
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if let json = response.result.value as? NSDictionary {
                let alarm = Alarm()
                alarm.setup(alarmJson: json)
                success(alarm)
            }
        }
    }
}
