//
//  ProjectListViewController.swift
//  tw-experiment
//
//  Created by TW-LostSeaWay on 10/10/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit

class ProjectListViewController: UITableViewController {
    
    var viewModel:ProjectListViewModel? = nil
    var textField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        viewModel = ProjectListViewModel(context: appDelegate.persistentContainer.viewContext)
        
        self.navigationItem.title = "Project List"
        
    }
    
    func insertNewObject(_ sender: Any) {
        
        let alert = UIAlertController(title: "Create Project", message: "Project Name : ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: { [unowned self] textField in
            self.textField = textField
            })
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { [unowned self] _ in
                if (self.viewModel?.createProject(name: (self.textField?.text)!))! {
                    self.tableView.reloadData()
                }
            }
    ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.projects.count)!
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = viewModel?.projects[indexPath.row].name!

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
