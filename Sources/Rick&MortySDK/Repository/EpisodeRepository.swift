import Foundation
import Combine

class EpisodeRepository {
    private var remoteDataSource = EpisodeRemoteDataSource()
    
    func getAllEpisodes() -> Future <[EpisodeModel], Error> {
        return remoteDataSource.getAllEpisodes()
    }
    
    func getEpisodeById(id: Int) -> Future <EpisodeModel, Error> {
        return remoteDataSource.getEpisodeByID(id: id)
    }
    
    func getEpisodesByIds(ids: [Int]) -> Future <[EpisodeModel], Error> {
        return remoteDataSource.getEpisodesByID(ids: ids)
    }
    
    func getEpisodeByFilter(name: String?, episode: String?) -> Future <[EpisodeModel], Error> {
        let filter = remoteDataSource.createEpisodeFilter(name: name, episode: episode)
        return remoteDataSource.getEpisodesByFilter(filter: filter)
    }
}
