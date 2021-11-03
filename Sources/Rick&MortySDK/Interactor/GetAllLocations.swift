import Foundation
import Combine

class GetAllLocations {
    
    private let repository = LocationRepository()
    
    func execute() -> Future <[LocationModel], Error>  {
        return repository.getAllLocations()
    }
}
