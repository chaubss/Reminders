//
//  PreviewViewController.swift
//  Reminders
//
//  Created by Aryan Chaubal on 12/5/17.
//  Copyright © 2017 Aryan Chaubal. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    var titleText = String()
    var needsNotification = Bool()
    var date = Date()
    @IBOutlet weak var notifSwitch: UISwitch!
    @IBOutlet weak var titleFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
                titleFld.text = titleText
                datePicker.date = date
                notifSwitch.isOn = needsNotification
        
    }

    func updateView(){
        

    }
    

}
