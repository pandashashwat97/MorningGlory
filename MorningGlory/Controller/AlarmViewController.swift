//
//  AlarmViewController.swift
//  MorningGlory
//
//  Created by Shashwat Panda on 28/12/22.
//

import UIKit
import UserNotifications
class AlarmViewController: UIViewController {
    
    @IBOutlet weak var notificationStatusLabel: UILabel!
    @IBOutlet weak var notificationStatus: UISwitch!
    @IBOutlet weak var alarmTitle: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        alarmTitle.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Denied")
            }
        }
        //for first time respnse
        if(notificationStatus.isOn){
            notificationStatusLabel.text = "Notification Enabled"
        }
        else
        {
            notificationStatusLabel.text = "Notification Disabled"
        }
    }
    func formattedDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MM y HH:mm"
        return formatter.string(from: date)
    }
    
    @IBAction func notificationCurrentStatus(_ sender: UISwitch) {
        if(notificationStatus.isOn){
            notificationStatusLabel.text = "Notification Enabled"
        }
        else
        {
            notificationStatusLabel.text = "Notification Disabled"
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
extension AlarmViewController: UITextFieldDelegate{
   
        @IBAction func setAlarm(_ sender: UIButton) {
            let targetDate = self.dateField.date
            let titleTxt = self.alarmTitle.text
            if (notificationStatus.isOn) {
                if  !(titleTxt!).isEmpty{
                    let content = UNMutableNotificationContent()
                    content.title = titleTxt!
                    content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm.mp3"))
                    let getDate = targetDate.addingTimeInterval(3)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: getDate), repeats: true)
                    let request = UNNotificationRequest(identifier: "id_\(titleTxt!)", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request){
                        (err) in
                        if err != nil {
                            print("something wrong")
                        }
                    }
                }
                self.dismiss(animated: true)
            }
            
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        alarmTitle.endEditing(true)
        return true
    }
}
