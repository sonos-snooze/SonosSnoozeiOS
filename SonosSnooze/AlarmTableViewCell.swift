//
//  AlarmTableViewCell.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/8/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    private var alarmTime: String = ""
    private var spotifySong: String = ""
    private var spotifyArtist: String = ""
    private var isOn: Bool = false

    @IBOutlet var alarmSwitch: UISwitch!
    @IBOutlet var isAM: UILabel!
    @IBOutlet var songName: UILabel!
    @IBOutlet var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setUp(alarmTime: String, isAM: Bool, spotifySong: String, spotifyArtist: String, isOn: Bool) {
        self.alarmTime = alarmTime
        self.spotifySong = spotifySong
        self.isOn = isOn
        
        alarmSwitch.isOn = self.isOn
        time.text = self.alarmTime
        self.isAM.text = (isAM) ? "" : ""
        songName.text = spotifySong + " - " + spotifyArtist
    }
}
