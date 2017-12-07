// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.swift instead.

import Foundation
import CoreData

public enum AreaAttributes: String {
    case id = "id"
    case lat = "lat"
    case lng = "lng"
    case name = "name"
}

public enum AreaRelationships: String {
    case adresses = "adresses"
    case province = "province"
}

open class _Area: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Area"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Area.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var id: NSNumber?

    @NSManaged open
    var lat: NSNumber?

    @NSManaged open
    var lng: NSNumber?

    @NSManaged open
    var name: String?

    // MARK: - Relationships

    @NSManaged open
    var adresses: NSOrderedSet

    open func adressesSet() -> NSMutableOrderedSet {
        return self.adresses.mutableCopy() as! NSMutableOrderedSet
    }

    @NSManaged open
    var province: Province?

}

extension _Area {

    open func addAdresses(_ objects: NSOrderedSet) {
        let mutable = self.adresses.mutableCopy() as! NSMutableOrderedSet
        mutable.union(objects)
        self.adresses = mutable.copy() as! NSOrderedSet
    }

    open func removeAdresses(_ objects: NSOrderedSet) {
        let mutable = self.adresses.mutableCopy() as! NSMutableOrderedSet
        mutable.minus(objects)
        self.adresses = mutable.copy() as! NSOrderedSet
    }

    open func addAdressesObject(_ value: Address) {
        let mutable = self.adresses.mutableCopy() as! NSMutableOrderedSet
        mutable.add(value)
        self.adresses = mutable.copy() as! NSOrderedSet
    }

    open func removeAdressesObject(_ value: Address) {
        let mutable = self.adresses.mutableCopy() as! NSMutableOrderedSet
        mutable.remove(value)
        self.adresses = mutable.copy() as! NSOrderedSet
    }

}

