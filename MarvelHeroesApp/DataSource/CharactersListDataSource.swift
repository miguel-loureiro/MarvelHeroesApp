//
//  CharactersListDataSource.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 21/12/2022.
//

import Foundation

class CharacterListDataSource {
    
    //    MARK: private variables

    private var apiManager: RequestManagerProtocol
    private var offset = 0

    //    MARK: public variables

    var characters: [CharacterModel] = []

    init(characters: [CharacterModel],
         apiManager: RequestManagerProtocol) {
        self.characters = characters
        self.apiManager = apiManager
    }

    //    MARK: getting model information

    @discardableResult func fetchCharacters() async -> [CharacterModel] {

        do {
            if let fetchedData:CharacterResponse =  try? await self.apiManager.fetchData(limit: Constants.API.limit ,
                                                                                         offset: offset ,
                                                                                         typeOf: .characters) {
                let characters = fetchedData.data.convertTo()
                self.offset = self.offset + characters.count

                return characters

            } else {
                throw RequestError.emptyData
            }
        } catch  {
            return self.characters
        }
    }

    //    MARK: Internal

    func getIndexPathsToReload(_ initialOffset: Int) -> [IndexPath]? {
        if initialOffset < self.characters.count {
            return (initialOffset...self.characters.count - 1).map {
                IndexPath(item: $0, section: 0)
            }
        }
        return nil
    }
}

// MARK: - Private

private extension CharacterData {
    func convertTo() -> [CharacterModel] {
        var list: [CharacterModel] = []
        for character in self.results {
            let character = CharacterModel(id: character.id,
                                           name: character.name,
                                           url: buildThumbnailURL(of: character))
            list.append(character)
        }
        return list
    }

    //    MARK: Internal

    private func buildThumbnailURL(of character: Character) -> URL? {

        if let thumbnail = character.thumbnail {
            let replaceURL = thumbnail.path.replacingOccurrences(of: "http", with: "https")

            return URL(string: replaceURL +  "/standard_xlarge." + thumbnail.thumbnailExtension)
        }
        return nil
    }
}
