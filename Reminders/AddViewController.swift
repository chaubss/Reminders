//
//  AddViewController.swift
//  Reminders
//
//  Created by Aryan Chaubal on 10/26/17.
//  Copyright © 2017 Aryan Chaubal. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var titleFld: UITextField!
    @IBOutlet weak var notifSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        saveBtn.isEnabled = false
        
        // Do any additional setup after loading the view.
        
        
         let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false

        
        
    }
    
    
    
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editingFld(_ sender: Any) {
        
        let fld = sender as! UITextField
        if fld.text == ""{
            saveBtn.isEnabled = false
        }else {
            saveBtn.isEnabled = true
        }
        
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        let title = titleFld.text!
        let needsNotif = (notifSwitch.isOn) ? true : false
        let date = datePicker.date
        
        insertData(title: title, date: date, needsNotification: needsNotif)
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
        
    }
    
    func insertData(title: String, date: Date, needsNotification: Bool){
        
        let reminder = Reminder(context: context)
        
        reminder.title = title
        reminder.date = date
        reminder.needsNotification = needsNotification
        
        appDelegate.saveContext()
        
        
        
    }

    
    
    
    
    
}
