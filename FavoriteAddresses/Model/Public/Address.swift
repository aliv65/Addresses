import Foundation
import MagicalRecord

@objc(Address)
open class Address: _Address {
    class func address(with model: AddressResponseModel, in context: NSManagedObjectContext) -> Address? {
        let address = self.mr_createEntity(in: context)
        address?.update(with: model)
        return address
    }
    
    func update(with model: AddressResponseModel) {
        self.label = model.name
        self.area = model.area
        self.areaId = NSNumber(value: model.areaId)
        self.apartment = model.apartment
        self.apartmentNo = model.apartmentNo
        self.block = model.block
        self.street = model.street
        self.floor = NSNumber(value: model.floor)
        self.phone = model.phone
        self.instructions = model.instructions
        self.preview = model.preview
        self.province = model.province
        self.lat = NSNumber(value: model.lat)
        self.lng = NSNumber(value: model.lng)
    }
}
