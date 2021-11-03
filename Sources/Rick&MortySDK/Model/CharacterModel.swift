import Foundation

public struct CharacterModel: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: LocationModel
    public let location: LocationModel
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}
