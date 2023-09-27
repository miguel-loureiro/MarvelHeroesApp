//
//  Lists.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 11/01/2023.
//

import Foundation

class DetailsDataSource {
    
    //    MARK: private variables

    private var apiManager: RequestManagerProtocol
    
    enum DetailSection: Int, CaseIterable, CustomStringConvertible {
        case comics = 0, events, series, stories
        var description: String {
            get {
                switch self {
                case .comics:
                    return "Comics"
                case .events:
                    return "Events"
                case .series:
                    return "Series"
                case .stories:
                    return "Stories"
                }
            }
        }
    }
    
    var titles : [DetailSection]
    
    //    MARK: public variables
    
    var character: CharacterModel
    var comics: [CESSModel] = []
    var events: [CESSModel] = []
    var series: [CESSModel] = []
    var stories: [CESSModel] = []
    var cess = [DetailSection : [CESSModel]]()

    var md5Hash = MD5Hash().generate()
    
    //    MARK: getting characters
    
    init(character: CharacterModel, apiManager: RequestManagerProtocol) {
        self.apiManager = apiManager
        self.character = character
        self.titles = DetailSection.allCases.map({$0})
    }
    
    // MARK: getting data
    
    func fetchCESS(request: Request) async -> [CESSModel] {
        
        do {
            if let fetchedData:CESSResponse =  try? await self.apiManager.fetchData(limit: Constants.API.limit ,offset: nil , typeOf: request)
            {
                return fetchedData.data.convertToCESS()
            }
            throw RequestError.emptyData
        } catch  {
            return []
        }
    }
    
    // MARK: parallel tasks
    
    func fetchCESSDataParallel() async throws -> [DetailSection : [CESSModel]] {

        //        MARK: asynchronous fetch data
        
        async let comics = self.fetchCESS(request: .comic(characterId: self.character.id))
        async let events = self.fetchCESS(request: .event(characterId: self.character.id))
        async let series = self.fetchCESS(request: .serie(characterId: self.character.id))
        async let stories = self.fetchCESS(request: .story(characterId: self.character.id))
        
        //        MARK: all data is fetched and now start appending sequentially
        
        cess[.comics] = await comics.shuffled()
        cess[.events] = await events.shuffled()
        cess[.series] = await series.shuffled()
        cess[.stories] = await stories.shuffled()

        return cess
    }
    
    func numberOfRowsInDetailsSections(of section: Int) -> Int {
        let sectionDetailSection = titles[section]
        if let items = cess[sectionDetailSection] {
            return min(items.count, Constants.DetailsDataSource.maximumElementsToDisplay)
        }
        return 0
    }
    
    func numberOfSections() -> Int {
        return updateTitles().count
    }
    
    func rowsOfSection(from cess: [DetailSection : [CESSModel]], at indexPath: IndexPath) -> CESSModel? {
        let titles = updateTitles()
        let section = titles[indexPath.section]
        if let item = cess[section] {
            return item[indexPath.row]
        }
        return nil
    }

    // MARK: create an array of sections that have data
    
    private func updateTitles() -> [DetailSection] {
        for (section, items) in self.cess {
            if items.count < 1 {
                if let index = titles.firstIndex(of: section) {
                    titles.remove(at: index)
                }
            }
        }
        return titles
    }
}

//    MARK: - Private
private extension CESSData {
    
    func convertToCESS() -> [CESSModel] {
        return self.results.map { CESSModel(id: $0.id,
                                            title: $0.title,
                                            description: $0.description) }
    }
}
