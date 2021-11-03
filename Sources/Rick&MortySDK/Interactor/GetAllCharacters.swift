import Foundation
import Combine

class GetAllCharacters {
    
    private let repository = CharacterRepository()
    
    func execute() -> Future <[CharacterModel], Error>  {
        return repository.getAllCharracters()
    }
}
