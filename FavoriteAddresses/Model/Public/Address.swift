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
        self.label = model.addressName
        self.area = model.addressArea
        self.areaId = NSNumber(value: model.addressAreaId)
        self.apartment = model.addressApartment
        self.apartmentNo = model.addressApartmentNo
        self.block = model.addressBlock
        self.street = model.addressStreet
        self.floor = NSNumber(value: model.addressFloor)
        self.phone = model.addressPhone
        self.instructions = model.addressInstructions
        self.preview = model.addressPreview
        self.province = model.addressProvince
        self.lat = NSNumber(value: model.addressLatitude)
        self.lng = NSNumber(value: model.addressLongitude)
    }
}
