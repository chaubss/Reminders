
//
//  DetailViewController.swift
//  Reminders
//
//  Created by Aryan Chaubal on 11/29/17.
//  Copyright © 2017 Aryan Chaubal. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var reminders = [NSManagedObject]()
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleFld: UITextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    
    var reminderToShow = NSManagedObject()
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black

        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // not on iOS 11, uses normal navigation bars
        }
        
        titleFld.text = (reminderToShow.value(forKey: "title") as? String)!
        datePicker.date = (reminderToShow.value(forKey: "date") as? Date)!
        notificationSwitch.isOn = (reminderToShow.value(forKey: "needsNotification") as? Bool)!
        self.title = (reminderToShow.value(forKey: "title") as? String)!
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        reminders = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        
        do {
            reminders = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError{
            print(String(describing: error))
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        reminders[selectedIndex].setValue(titleFld.text, forKey: "title")
        reminders[selectedIndex].setValue(datePicker.date, forKey: "date")
        reminders[selectedIndex].setValue(notificationSwitch.isOn, forKey: "needsNotification")
        

        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
