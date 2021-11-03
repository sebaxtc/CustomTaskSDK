import Combine

public struct Rick_MortySDK {
    private var getAllCharactersUseCase = GetAllCharacters()
    private var getCharacterByIdUseCase = GetCharacterById()
    private var getCharactersByIdsUseCase = GetCharactersByIds()
    private var getCharactersByFilterUseCase = GetCharacterByFilter()
    
    private var getAllEpisodesUseCase = GetAllEpisodes()
    private var getEpisodeByIdUseCase = GetEpisodeById()
    private var getEpisodesByIdsUseCase = GetEpisodesByIds()
    private var getEpisodeByFilterUseCase = GetEpisodeByFilter()
    
    private var getAllLocationsUseCase = GetAllLocations()
    private var getLocationByIdUseCase = GetLocationById()
    private var getLocationsByIdsUseCase = GetLocationsByIds()
    private var getLocationByFilterUseCase = GetLocationByFilter()

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
    
    public func getAllEpisodes() -> Future <[EpisodeModel], Error>  {
        return getAllEpisodesUseCase.execute()
    }
    
    public func getEpisodeById(id: Int) -> Future <EpisodeModel, Error> {
        return getEpisodeByIdUseCase.execute(id: id)
    }
    
    public func getEpisodesByIds(ids: [Int]) -> Future <[EpisodeModel], Error> {
        return getEpisodesByIdsUseCase.execute(ids: ids)
    }
    
    public func getEpisodeByFilter(name: String?, episode: String?) -> Future <[EpisodeModel], Error> {
        return getEpisodeByFilterUseCase.execute(name: name, episode: episode)
    }
    
    public func getAllLocations() -> Future <[LocationModel], Error>  {
        return getAllLocationsUseCase.execute()
    }
    
    public func getLocationById(id: Int) -> Future <LocationModel, Error> {
        return getLocationByIdUseCase.execute(id: id)
    }
    
    public func getLocationsByIds(ids: [Int]) -> Future <[LocationModel], Error> {
        return getLocationsByIdsUseCase.execute(ids: ids)
    }
    
    public func getCharactersByFilter(name: String?, type: String?, dimension: String?) -> Future <[LocationModel], Error> {
        return getLocationByFilterUseCase.execute(name: name, type: type, dimension: dimension)
    }
}
