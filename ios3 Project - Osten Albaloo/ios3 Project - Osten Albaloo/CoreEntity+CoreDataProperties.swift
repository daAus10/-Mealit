//
//  CoreEntity+CoreDataProperties.swift
//  ios3 Project - Osten Albaloo
//
//  Created by Austin Albaloo on 2022-11-07.
//
//

import Foundation
import CoreData


extension CoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreEntity> {
        return NSFetchRequest<CoreEntity>(entityName: "CoreEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var picture: String
    @NSManaged public var instructs: String
    @NSManaged public var ingreds: String

}

extension CoreEntity : Identifiable {

}
