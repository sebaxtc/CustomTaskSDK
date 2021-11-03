import Combine

public struct Rick_MortySDK {
    private var getAllCharactersUseCase = GetAllCharacters()
    private var getCharacterByIdUseCase = GetCharacterById()

    public init() {
    }
    
    public func getAllCharacters() -> Future <[CharacterModel], Error>  {
        return getAllCharactersUseCase.execute()
    }
    
    public func getCharacterById(id: Int) -> Future <CharacterModel, Error> {
        return getCharacterByIdUseCase.execute(id: id)
    }
}
