//
//  Employee.swift
//  Project
//
//  Created by bmiit on 12/04/22.
//

import CoreData

@objc(Employee)
class Employee: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var designation: String!
    @NSManaged var deletedDate: Date?
}
