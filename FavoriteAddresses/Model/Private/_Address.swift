// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Address.swift instead.

import Foundation
import CoreData

public enum AddressAttributes: String {
    case apartment = "apartment"
    case apartmentNo = "apartmentNo"
    case area = "area"
    case areaId = "areaId"
    case avenue = "avenue"
    case block = "block"
    case building = "building"
    case floor = "floor"
    case id = "id"
    case instructions = "instructions"
    case label = "label"
    case lat = "lat"
    case lng = "lng"
    case phone = "phone"
    case preview = "preview"
    case province = "province"
    case street = "street"
}

open class _Address: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Address"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Address.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var apartment: String?

    @NSManaged open
    var apartmentNo: String?

    @NSManaged open
    var area: String?

    @NSManaged open
    var areaId: NSNumber?

    @NSManaged open
    var avenue: String?

    @NSManaged open
    var block: String?

    @NSManaged open
    var building: String?

    @NSManaged open
    var floor: NSNumber?

    @NSManaged open
    var id: NSNumber?

    @NSManaged open
    var instructions: String?

    @NSManaged open
    var label: String?

    @NSManaged open
    var lat: NSNumber?

    @NSManaged open
    var lng: NSNumber?

    @NSManaged open
    var phone: String?

    @NSManaged open
    var preview: String?

    @NSManaged open
    var province: String?

    @NSManaged open
    var street: String?

    // MARK: - Relationships

}

