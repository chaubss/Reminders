//
//  SettingsTableViewController.swift
//  Reminders
//
//  Created by Aryan Chaubal on 12/5/17.
//  Copyright © 2017 Aryan Chaubal. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // not on iOS 11, uses normal navigation bars
        }
        self.navigationController?.navigationBar.tintColor = UIColor.black

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    

    
   
    

}
