//
//  EmployeeTableView.swift
//  Project
//
//  Created by bmiit on 12/04/22.
//

import UIKit
import CoreData

var employeeList = [Employee]()

class EmployeeTableView: UITableViewController
{
    var firstLoad = true
    
    func nonDeletedNotes() -> [Employee]
    {
        var noDeleteemployeeList = [Employee]()
        
        for  employee in employeeList
        {
            if(employee.deletedDate == nil)
            {
                noDeleteemployeeList.append(employee)
            }
        }
        return noDeleteemployeeList
    }
    
    override func viewDidLoad()
    {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            do
            {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let employee = result as! Employee
                    employeeList.append(employee)
                }
            } catch
            {
                print("fetch failed....")
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let employeeCell = tableView.dequeueReusableCell(withIdentifier: "employeeCellID", for: indexPath) as! EmployeeCell
        
        let thisEmployee: Employee!
        thisEmployee = nonDeletedNotes()[indexPath.row]
        
        employeeCell.nameLable.text = thisEmployee.name
        employeeCell.designationLable.text = thisEmployee.designation
        
        return employeeCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedNotes().count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editEmployee", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "editEmployee")
        {
            let indexpath = tableView.indexPathForSelectedRow!
            
            let employeeDetail = segue.destination as? EmployeeDetailVC
            
            let selectedEmployee : Employee!
            selectedEmployee = nonDeletedNotes()[indexpath.row]
            employeeDetail!.selectedEmployee = selectedEmployee
            
            tableView.deselectRow(at: indexpath, animated: true)
        }
    }

}
