//
//  TableViewController.swift
//  Reminders
//
//  Created by Aryan Chaubal on 10/26/17.
//  Copyright © 2017 Aryan Chaubal. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController, UIViewControllerPreviewingDelegate {
	
	var reminders = [NSManagedObject]()
	var index = Int()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		tableView.reloadData()

		
		if traitCollection.forceTouchCapability == .available{
			registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: tableView)
		}else{
			// No 3D Touch
		}
		
		
		if #available(iOS 11.0, *) {
			self.navigationController?.navigationBar.prefersLargeTitles = false
			self.navigationController?.navigationBar.prefersLargeTitles = true
			self.navigationItem.largeTitleDisplayMode = .always
		} else {
			// not on iOS 11, uses normal navigation bars
		}
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//        if #available(iOS 11.0, *) {
		//            self.navigationController?.navigationBar.prefersLargeTitles = true
		//            self.navigationItem.largeTitleDisplayMode = .always
		//        } else {
		//            // not on iOS 11, uses normal navigation bars
		//        }
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		
		// get the core data stuff
		reminders = []
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
		
		do {
			reminders = try context.fetch(fetchRequest) as! [NSManagedObject]
		} catch let error as NSError{
			print(String(describing: error))
		}
		tableView.reloadData()
		
		
	}
	
	// MARK: - Table view data source
	
	
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return reminders.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		let reminder = reminders[indexPath.row]
		
		cell.textLabel?.text = reminder.value(forKey: "title") as? String
		
		
		
		
		
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == UITableViewCellEditingStyle.delete{
			
			let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this reminder?", preferredStyle: .actionSheet)
			alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
				context.delete(self.reminders[indexPath.row])
				self.reminders.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .automatic)
				do {
					try context.save()
					
				}catch {
					print("error")
				}
				tableView.reloadData()
			}))
			self.present(alert, animated: true, completion: nil)
			
		}
	}
	
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
		detailVC.reminderToShow = reminders[indexPath.row]
		detailVC.selectedIndex = indexPath.row
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
	//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	//        performSegue(withIdentifier: "cellPressed", sender: self)
	//
	//    }
	//
	
	
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		let vc = storyboard?.instantiateViewController(withIdentifier: "previewVC") as! PreviewViewController
		let reminderToPeek = reminders[(tableView.indexPathForRow(at: location)?.row)!]
		
		index = (tableView.indexPathForRow(at: location)?.row)!
		
		previewingContext.sourceRect.size = CGSize(width: 100, height: 100)
		vc.titleText = reminderToPeek.value(forKey: "title") as! String
		
		vc.date = reminderToPeek.value(forKey: "date") as! Date
		vc.needsNotification = reminderToPeek.value(forKey: "needsNotification") as! Bool
		vc.updateView()
		
		return vc
	}
	
	
	
	
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
		
		let detailVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
		detailVC.reminderToShow = reminders[index]
		detailVC.selectedIndex = index
		
		navigationController?.pushViewController(detailVC, animated: true)
		
		
	}
	
	
	
	
	
	
	
	
	
	
}
