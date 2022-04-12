//
//  ViewController.swift
//  Project
//
//  Created by bmiit on 12/04/22.
//

import UIKit
import CoreData

class EmployeeDetailVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var designationTF: UITextField!
    
    var selectedEmployee: Employee? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedEmployee != nil)
        {
            nameTF.becomeFirstResponder()
            nameTF.text = selectedEmployee?.name
            designationTF.text = selectedEmployee?.designation
        }
    }

    @IBAction func saveAction(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedEmployee == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
            
            let newEmployee = Employee(entity: entity!, insertInto: context)
            
            newEmployee.id = employeeList.count as NSNumber
            newEmployee.name = nameTF.text
            newEmployee.designation = designationTF.text
            do
            {
                try context.save()
                employeeList.append(newEmployee)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error...")
            }
        }
        else
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            do
            {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let employee = result as! Employee
                    if(employee == selectedEmployee)
                    {
                        employee.name = nameTF.text
                        employee.designation = designationTF.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch
            {
                print("fetch failed....")
            }
        }
    }
    
    @IBAction func deleteEmployee(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        do
        {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let employee = result as! Employee
                if(employee == selectedEmployee)
                {
                    employee.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch
        {
            print("fetch failed....")
        }
    }
}

