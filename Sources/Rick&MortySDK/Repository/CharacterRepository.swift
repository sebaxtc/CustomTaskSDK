import Foundation
import Combine

class CharacterRepository {
    private var remoteDataSource = CharacterRemoteDataSource()
    
    func getAllCharracters() -> Future <[CharacterModel], Error> {
        return remoteDataSource.getAllCharacters()
    }
    
    func getCharracterById(id: Int) -> Future <CharacterModel, Error> {
        return remoteDataSource.getCharacterByID(id: id)
    }
}
