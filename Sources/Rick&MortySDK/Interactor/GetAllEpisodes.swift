import Foundation
import Combine

class GetAllEpisodes {
    
    private let repository = EpisodeRepository()
    
    func execute() -> Future <[EpisodeModel], Error>  {
        return repository.getAllEpisodes()
    }
}
