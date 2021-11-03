import Foundation
import Combine

class GetEpisodesByIds {
    
    private let repository = EpisodeRepository()
    
    func execute(ids: [Int]) -> Future <[EpisodeModel], Error>  {
        return repository.getEpisodesByIds(ids: ids)
    }
}
