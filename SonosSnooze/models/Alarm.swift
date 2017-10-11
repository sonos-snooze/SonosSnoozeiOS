//
//  Alarm.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/9/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import Foundation

public class Alarm: NSObject {
    
    var name: String = ""
    var time: String = ""
    var isAM: Bool = false
    var isOn: Bool = false
    var userID: String = ""
    var id: Int = -1
    
    var spotifySongID: String = ""
    var spotifySongName: String = ""
    var spotifySongArtist: String = ""
    var spotifySongImgUrl: String = ""
    
    override init() {
        super.init()
    }
    
    func setup(alarmJson: NSDictionary) {
        self.name = alarmJson.object(forKey: "name") as! String
        self.time = alarmJson.object(forKey: "alarm_time") as! String
        self.time = self.time.substring(to: 5)
        self.isOn = alarmJson.object(forKey: "alarm_on") as! Bool
        
        if let spotifyID = alarmJson.object(forKey: "spotifySongID") as? String {
            self.spotifySongID = spotifyID
            spotifySongName = alarmJson.object(forKey: "spotifySongName") as! String
            spotifySongArtist = alarmJson.object(forKey: "spotifySongArtist") as! String
            spotifySongImgUrl = alarmJson.object(forKey: "spotifySongImgUrl") as! String
        }
    }
    
    func toJson() -> [String: Any] {
        return [
            "user_id": "1",
            "name": self.name,
            "alarm_time": self.time,
            "alarm_on": self.isOn,
            "spotifySongID": self.spotifySongID,
            "spotifySongName": self.spotifySongName,
            "spotifySongArtist": self.spotifySongArtist,
            "spotifySongImgUrl": self.spotifySongImgUrl
        ]
    }
}
