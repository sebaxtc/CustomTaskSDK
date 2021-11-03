import Foundation
import Combine

class LocationRemoteDataSource {
    let networkHandler: NetworkManager = NetworkManager()
    
    public func getLocationByID(id: Int) -> Future <LocationModel, Error> {
        return Future() { promise in
            self.networkHandler.performAPIRequestByMethod(method: "location/"+String(id)) {
                switch $0 {
                case .success(let data):
                    if let location: LocationModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(location))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getLocationsByID(ids: [Int]) -> Future <[LocationModel], Error> {
        return Future() { promise in
            let stringIDs = ids.map { String($0) }
            self.networkHandler.performAPIRequestByMethod(method: "location/"+stringIDs.joined(separator: ",")) {
                switch $0 {
                case .success(let data):
                    if let locations: [LocationModel] = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(locations))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getAllLocations() -> Future <[LocationModel], Error> {
        return Future() { promise in
            var allLocations = [LocationModel]()
            self.networkHandler.performAPIRequestByMethod(method: "location") {
                switch $0 {
                case .success(let data):
                    if let infoModel: LocationInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        allLocations = infoModel.results
                        let locationsDispatchGroup = DispatchGroup()
                        
                        for index in 2...infoModel.info.pages {
                            locationsDispatchGroup.enter()
                            
                            self.networkHandler.performAPIRequestByMethod(method: "location/"+"?page="+String(index)) {
                                switch $0 {
                                case .success(let data):
                                    if let infoModel: LocationInfoModel = self.networkHandler.decodeJSONData(data: data) {
                                        allLocations.append(contentsOf: infoModel.results)
                                        locationsDispatchGroup.leave()
                                    }
                                case .failure(let error):
                                    promise(.failure(error))
                                }
                            }
                        }
                        locationsDispatchGroup.notify(queue: DispatchQueue.main) {
                            promise(.success(allLocations.sorted { $0.id < $1.id }))
                        }
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    func createLocationFilter(name: String?, type: String?, dimension: String?) -> LocationFilter {
        
        let parameterDict: [String: String] = [
            "name" : name ?? "",
            "type" : type ?? "",
            "dimension" : dimension ?? ""
        ]
        
        var query = "location/?"
        for (key, value) in parameterDict {
            if value != "" {
                query.append(key+"="+value+"&")
            }
        }
        
        let filter = LocationFilter(name: parameterDict["name"]!, type: parameterDict["type"]!, dimension: parameterDict["dimension"]!, query: query)
        return filter
    }
    
    public func getLocationsByFilter(filter: LocationFilter) -> Future <[LocationModel], Error> {
        return Future() { promise in
            
            self.networkHandler.performAPIRequestByMethod(method: filter.query) {
                switch $0 {
                case .success(let data):
                    if let infoModel: LocationInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(infoModel.results))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}

public struct LocationFilter {
    public let name: String
    public let type: String
    public let dimension: String
    public let query: String
}

struct LocationInfoModel: Codable {
    let info: Info
    let results: [LocationModel]
}

