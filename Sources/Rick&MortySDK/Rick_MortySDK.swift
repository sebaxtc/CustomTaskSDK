import Combine

public struct Rick_MortySDK {
    private var getAllCharactersUseCase = GetAllCharacters()
    private var getCharacterByIdUseCase = GetCharacterById()
    private var getCharactersByIdsUseCase = GetCharactersByIds()
    private var getCharactersByFilterUseCase = GetCharacterByFilter()

    public init() {
    }
    
    public func getAllCharacters() -> Future <[CharacterModel], Error>  {
        return getAllCharactersUseCase.execute()
    }
    
    public func getCharacterById(id: Int) -> Future <CharacterModel, Error> {
        return getCharacterByIdUseCase.execute(id: id)
    }
    
    public func getCharactersByIds(ids: [Int]) -> Future <[CharacterModel], Error> {
        return getCharactersByIdsUseCase.execute(ids: ids)
    }
    
    public func getCharactersByFilter(name: String?, status: Status?, species: String?, type: String?, gender: Gender?) -> Future <[CharacterModel], Error> {
        return getCharactersByFilterUseCase.execute(name: name, status: status, species: species, type: type, gender: gender)
    }
}
