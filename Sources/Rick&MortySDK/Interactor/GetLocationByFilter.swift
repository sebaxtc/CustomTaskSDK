import Foundation
import Combine

class GetLocationByFilter {
    
    private let repository = LocationRepository()
    
    func execute(name: String?, type: String?, dimension: String?) -> Future <[LocationModel], Error>  {
        return repository.getLocationsByFilter(name: name, type: type, dimension: dimension)
    }
}
