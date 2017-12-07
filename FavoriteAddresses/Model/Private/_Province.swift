// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Province.swift instead.

import Foundation
import CoreData

public enum ProvinceAttributes: String {
    case id = "id"
    case name = "name"
}

public enum ProvinceRelationships: String {
    case areas = "areas"
}

open class _Province: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Province"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Province.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var id: NSNumber?

    @NSManaged open
    var name: String?

    // MARK: - Relationships

    @NSManaged open
    var areas: NSOrderedSet

    open func areasSet() -> NSMutableOrderedSet {
        return self.areas.mutableCopy() as! NSMutableOrderedSet
    }

}

extension _Province {

    open func addAreas(_ objects: NSOrderedSet) {
        let mutable = self.areas.mutableCopy() as! NSMutableOrderedSet
        mutable.union(objects)
        self.areas = mutable.copy() as! NSOrderedSet
    }

    open func removeAreas(_ objects: NSOrderedSet) {
        let mutable = self.areas.mutableCopy() as! NSMutableOrderedSet
        mutable.minus(objects)
        self.areas = mutable.copy() as! NSOrderedSet
    }

    open func addAreasObject(_ value: Area) {
        let mutable = self.areas.mutableCopy() as! NSMutableOrderedSet
        mutable.add(value)
        self.areas = mutable.copy() as! NSOrderedSet
    }

    open func removeAreasObject(_ value: Area) {
        let mutable = self.areas.mutableCopy() as! NSMutableOrderedSet
        mutable.remove(value)
        self.areas = mutable.copy() as! NSOrderedSet
    }

}

