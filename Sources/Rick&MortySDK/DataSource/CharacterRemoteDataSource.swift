import Foundation
import Combine

class CharacterRemoteDataSource {
    let networkHandler: NetworkManager = NetworkManager()
    
    func getAllCharacters() -> Future <[CharacterModel], Error> {
        return Future() { promise in
            var allCharacters = [CharacterModel]()
            self.networkHandler.performAPIRequestByMethod(method: "character") {
                switch $0 {
                case .success(let data):
                    if let infoModel: CharacterInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        allCharacters = infoModel.results
                        let charactersDispatchGroup = DispatchGroup()
                        
                        for index in 2...infoModel.info.pages {
                            charactersDispatchGroup.enter()
                            
                            self.networkHandler.performAPIRequestByMethod(method: "character/"+"?page="+String(index)) {
                                switch $0 {
                                case .success(let data):
                                    if let infoModel: CharacterInfoModel = self.networkHandler.decodeJSONData(data: data) {
                                        allCharacters.append(contentsOf: infoModel.results)
                                        charactersDispatchGroup.leave()
                                    }
                                case .failure(let error):
                                    promise(.failure(error))
                                }
                            }
                        }
                        charactersDispatchGroup.notify(queue: DispatchQueue.main) {
                            promise(.success(allCharacters.sorted { $0.id < $1.id }))
                        }
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getCharacterByID(id: Int) -> Future <CharacterModel, Error> {
        return Future() { promise in
            self.networkHandler.performAPIRequestByMethod(method: "character/"+String(id)) {
                switch $0 {
                case .success(let data):
                    if let character: CharacterModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(character))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getCharactersByID(ids: [Int]) -> Future <[CharacterModel], Error> {
        return Future() { promise in
            let stringIDs = ids.map { String($0) }
            self.networkHandler.performAPIRequestByMethod(method: "character/"+stringIDs.joined(separator: ",")) {
                switch $0 {
                case .success(let data):
                    if let characters: [CharacterModel] = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(characters))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }

    func createCharacterFilter(name: String?, status: Status?, species: String?, type: String?, gender: Gender?) -> CharacterFilter {
        
        let parameterDict: [String: String] = [
            "name" : name ?? "",
            "status" : status?.rawValue ?? "",
            "species" : species ?? "",
            "type" : type ?? "",
            "gender" : gender?.rawValue ?? ""
        ]
        
        var query = "character/?"
        for (key, value) in parameterDict {
            if value != "" {
                query.append(key+"="+value+"&")
            }
        }
        
        let filter = CharacterFilter(name: parameterDict["name"]!, status: parameterDict["status"]!, species: parameterDict["species"]!, type: parameterDict["type"]!, gender: parameterDict["gender"]!, query: query)
        return filter
    }
    
    public func getCharactersByFilter(filter: CharacterFilter) -> Future<[CharacterModel], Error> {
        return Future() { promise in
            
            self.networkHandler.performAPIRequestByMethod(method: filter.query) {
                switch $0 {
                case .success(let data):
                    if let infoModel: CharacterInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(infoModel.results))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}

public struct CharacterFilter {
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let query: String
}

struct CharacterInfoModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

public enum Status: String {
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    case none = ""
}

public enum Gender: String {
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    case none = ""
}
