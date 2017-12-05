//
//  SplitViewsTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/19/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import CoreData

class SplitViewsTableViewController: UITableViewController {
    
    var sessionsData: [[Double]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AllData")
        request.returnsObjectsAsFaults = false
        
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let data = result.value(forKey: "allData") as? [[Double]] {
                        sessionsData = data
                        
                        self.tableView.reloadData()
                    }
                }
            } else {
                print("no results")
            }
        } catch {
            print("error")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 100
        //return sessionsData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValueCell", for: indexPath)
        
        cell.textLabel?.text = String(sessionsData[Variables.tableIndex][indexPath.row])
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}

