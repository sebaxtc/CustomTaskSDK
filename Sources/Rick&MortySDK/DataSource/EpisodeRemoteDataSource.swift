import Foundation
import Combine

class EpisodeRemoteDataSource {
    let networkHandler: NetworkManager = NetworkManager()

    public func getEpisodeByID(id: Int) -> Future <EpisodeModel, Error> {
        return Future() { promise in
            self.networkHandler.performAPIRequestByMethod(method: "episode/"+String(id)) {
                switch $0 {
                case .success(let data):
                    if let episode: EpisodeModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(episode))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getEpisodesByID(ids: [Int]) -> Future <[EpisodeModel], Error> {
        return Future() { promise in
            let stringIDs = ids.map { String($0) }
            self.networkHandler.performAPIRequestByMethod(method: "episode/"+stringIDs.joined(separator: ",")) {
                switch $0 {
                case .success(let data):
                    if let episodes: [EpisodeModel] = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(episodes))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public func getAllEpisodes() -> Future <[EpisodeModel], Error> {
        return Future() { promise in
            var allEpisodes = [EpisodeModel]()
            self.networkHandler.performAPIRequestByMethod(method: "episode") {
                switch $0 {
                case .success(let data):
                    if let infoModel: EpisodeInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        allEpisodes = infoModel.results
                        let episodesDispatchGroup = DispatchGroup()
                        
                        for index in 2...infoModel.info.pages {
                            episodesDispatchGroup.enter()
                            
                            self.networkHandler.performAPIRequestByMethod(method: "episode/"+"?page="+String(index)) {
                                switch $0 {
                                case .success(let data):
                                    if let infoModel: EpisodeInfoModel = self.networkHandler.decodeJSONData(data: data) {
                                        allEpisodes.append(contentsOf: infoModel.results)
                                        episodesDispatchGroup.leave()
                                    }
                                case .failure(let error):
                                    promise(.failure(error))
                                }
                            }
                        }
                        episodesDispatchGroup.notify(queue: DispatchQueue.main) {
                            promise(.success(allEpisodes.sorted { $0.id < $1.id }))
                        }
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    func createEpisodeFilter(name: String?, episode: String?) -> EpisodeFilter {
        
        let parameterDict: [String: String] = [
            "name" : name ?? "",
            "episode" : episode ?? ""
        ]
        
        var query = "episode/?"
        for (key, value) in parameterDict {
            if value != "" {
                query.append(key+"="+value+"&")
            }
        }
        
        let filter = EpisodeFilter(name: parameterDict["name"]!, episode: parameterDict["episode"]!, query: query)
        return filter
    }
    
    public func getEpisodesByFilter(filter: EpisodeFilter) -> Future <[EpisodeModel], Error> {
        return Future() { promise in
            
            self.networkHandler.performAPIRequestByMethod(method: filter.query) {
                switch $0 {
                case .success(let data):
                    if let infoModel: EpisodeInfoModel = self.networkHandler.decodeJSONData(data: data) {
                        promise(.success(infoModel.results))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}

public struct EpisodeFilter {
    public let name: String
    public let episode: String
    public let query: String
}

struct EpisodeInfoModel: Codable {
    let info: Info
    let results: [EpisodeModel]
}

