//
//  ViewController.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/8/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import UIKit

class AlarmViewController: UITableViewController {
    
    var alarms: [Alarm] = []
    
    func success(_ alarms: [Alarm]) {
        self.alarms = alarms
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlarmAPI.getAlarms(success: success)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AlarmAPI.getAlarms(success: success)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
        
        let index = indexPath.row
        let alarm = alarms[index]
        var songName = "No Song Selected"
        var spotifyArtist = ""
        
        if alarm.spotifySongName != "" {
            songName = alarm.spotifySongName
            spotifyArtist = alarm.spotifySongArtist
        }
        
        
        cell.setUp(alarmTime: alarm.time, isAM: alarm.isOn, spotifySong: songName, spotifyArtist: spotifyArtist, isOn: alarm.isOn);
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "alarmDetailSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
