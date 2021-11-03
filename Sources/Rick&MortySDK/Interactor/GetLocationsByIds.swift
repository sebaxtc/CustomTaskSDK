import Foundation
import Combine

class GetLocationsByIds {
    
    private let repository = LocationRepository()
    
    func execute(ids: [Int]) -> Future <[LocationModel], Error>  {
        return repository.getLocationsByIds(ids: ids)
    }
}
