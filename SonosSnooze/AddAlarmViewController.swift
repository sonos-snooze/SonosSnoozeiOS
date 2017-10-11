//
//  AddAlarmViewController.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/8/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import UIKit
import Kingfisher

class AddAlarmViewController: UIViewController {

    @IBOutlet var songImage: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var snoozeSwitch: UISwitch!
    var songID: String = "2gZUPNdnz5Y45eiGxpHGSc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitle.text = "Power"
        songArtist.text = "Kanye West"
        let url = URL(string: "https://i.scdn.co/image/1610aeab18aa441a0a7fc4870ebb9d9060c47395")
        songImage.kf.setImage(with: url)
    }

    @IBAction func saveAlarmPressed(_ sender: Any) {
        var alarm = Alarm()
        
        alarm.name = "Morning Alarm"
        alarm.userID = "1"
        
        let date = self.datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let time = formatter.string(from: date)
        alarm.time = time
        alarm.spotifySongImgUrl = "https://i.scdn.co/image/1610aeab18aa441a0a7fc4870ebb9d9060c47395"
        alarm.spotifySongArtist = "Kanye West"
        alarm.spotifySongName = "Power"
        alarm.spotifySongID = self.songID
        alarm.isOn = true
        
        func success(_ alarm: Alarm) {
            self.navigationController?.popViewController(animated: true)
        }
        
        AlarmAPI.makeAlarm(alarm, success: success)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
