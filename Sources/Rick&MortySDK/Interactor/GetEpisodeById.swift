import Foundation
import Combine

class GetEpisodeById  {
    
    private let repository = EpisodeRepository()
    
    func execute(id: Int) -> Future <EpisodeModel, Error>  {
        return repository.getEpisodeById(id: id)
    }
}
