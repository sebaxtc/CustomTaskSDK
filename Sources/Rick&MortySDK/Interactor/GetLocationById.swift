import Foundation
import Combine

class GetLocationById  {
    
    private let repository = LocationRepository()
    
    func execute(id: Int) -> Future <LocationModel, Error>  {
        return repository.getLocationById(id: id)
    }
}
