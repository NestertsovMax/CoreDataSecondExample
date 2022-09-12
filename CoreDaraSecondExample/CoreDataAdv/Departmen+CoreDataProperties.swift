//
//  Departmen+CoreDataProperties.swift
//  CoreDaraSecondExample
//
//  Created by M1 on 12.09.2022.
//
//

import Foundation
import CoreData


extension Departmen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Departmen> {
        return NSFetchRequest<Departmen>(entityName: "Departmen")
    }

    @NSManaged public var name: String?
    @NSManaged public var worker: NSSet?

}

// MARK: Generated accessors for worker
extension Departmen {

    @objc(addWorkerObject:)
    @NSManaged public func addToWorker(_ value: Worker)

    @objc(removeWorkerObject:)
    @NSManaged public func removeFromWorker(_ value: Worker)

    @objc(addWorker:)
    @NSManaged public func addToWorker(_ values: NSSet)

    @objc(removeWorker:)
    @NSManaged public func removeFromWorker(_ values: NSSet)

}

extension Departmen : Identifiable {

}
