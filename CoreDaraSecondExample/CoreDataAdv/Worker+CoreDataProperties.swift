//
//  Worker+CoreDataProperties.swift
//  CoreDaraSecondExample
//
//  Created by M1 on 12.09.2022.
//
//

import Foundation
import CoreData


extension Worker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Worker> {
        return NSFetchRequest<Worker>(entityName: "Worker")
    }

    @NSManaged public var name: String?
    @NSManaged public var salary: Int64
    @NSManaged public var department: Departmen?

}

extension Worker : Identifiable {

}
