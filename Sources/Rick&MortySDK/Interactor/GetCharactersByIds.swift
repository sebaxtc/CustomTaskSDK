import Foundation
import Combine

class GetCharactersByIds {
    
    private let repository = CharacterRepository()
    
    func execute(ids: [Int]) -> Future <[CharacterModel], Error>  {
        return repository.getCharactersByIds(ids: ids)
    }
}
