import Foundation
import Combine

class GetEpisodeByFilter {
    
    private let repository = EpisodeRepository()
    
    func execute(name: String?, episode: String?) -> Future <[EpisodeModel], Error>  {
        return repository.getEpisodeByFilter(name: name, episode: episode)
    }
}
