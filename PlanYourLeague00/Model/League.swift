//
//  League.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/29/24.
//
import Foundation
import CoreData

public class League: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<League> {
        return NSFetchRequest<League>(entityName: "League")
    }
    
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var address: String
    @NSManaged public var describe: String
    @NSManaged public var phone: String
    @NSManaged public var email: String
    @NSManaged public var manager: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
}
