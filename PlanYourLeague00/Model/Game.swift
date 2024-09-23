//
//  Game.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 9/9/24.
//

import Foundation
import CoreData

public class Game: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Match")
    }
    
    @NSManaged var leagueName: String
    @NSManaged var date: String
    @NSManaged var team1Logo: Data
    @NSManaged var team1Name: String
    @NSManaged var team1Goal: Int
    @NSManaged var team2Logo: Data
    @NSManaged var team2Name: String
    @NSManaged var team2Goal: Int
}
