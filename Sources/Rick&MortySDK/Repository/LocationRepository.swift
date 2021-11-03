import Foundation
import Combine

class LocationRepository {
    private var remoteDataSource = LocationRemoteDataSource()
    
    func getAllLocations() -> Future <[LocationModel], Error> {
        return remoteDataSource.getAllLocations()
    }
    
    func getLocationById(id: Int) -> Future <LocationModel, Error> {
        return remoteDataSource.getLocationByID(id: id)
    }
    
    func getLocationsByIds(ids: [Int]) -> Future <[LocationModel], Error> {
        return remoteDataSource.getLocationsByID(ids: ids)
    }
    
    func getLocationsByFilter(name: String?, type: String?, dimension: String?) -> Future <[LocationModel], Error> {
        let filter = remoteDataSource.createLocationFilter(name: name, type: type, dimension: dimension)
        return remoteDataSource.getLocationsByFilter(filter: filter)
    }
}
