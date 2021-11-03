import Foundation
import Combine

class GetCharacterByFilter {
    
    private let repository = CharacterRepository()
    
    func execute(name: String?, status: Status?, species: String?, type: String?, gender: Gender?) -> Future <[CharacterModel], Error>  {
        return repository.getCharactersByFilter(name: name, status: status, species: species, type: type, gender: gender)
    }
}
