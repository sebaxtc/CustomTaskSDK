import Foundation
import Combine

class CharacterRepository {
    private var remoteDataSource = CharacterRemoteDataSource()
    
    func getAllCharracters() -> Future <[CharacterModel], Error> {
        return remoteDataSource.getAllCharacters()
    }
    
    func getCharacterById(id: Int) -> Future <CharacterModel, Error> {
        return remoteDataSource.getCharacterByID(id: id)
    }
    
    func getCharactersByIds(ids: [Int]) -> Future <[CharacterModel], Error> {
        return remoteDataSource.getCharactersByID(ids: ids)
    }
    
    func getCharactersByFilter(name: String?, status: Status?, species: String?, type: String?, gender: Gender?) -> Future <[CharacterModel], Error> {
        let filter = remoteDataSource.createCharacterFilter(name: name, status: status, species: species, type: type, gender: gender)
        return remoteDataSource.getCharactersByFilter(filter: filter)
    }
}
