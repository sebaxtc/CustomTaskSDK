import Foundation
import Combine

class GetCharacterById {
    
    private let repository = CharacterRepository()
    
    func execute(id: Int) -> Future <CharacterModel, Error>  {
        return repository.getCharracterById(id: id)
    }
}
