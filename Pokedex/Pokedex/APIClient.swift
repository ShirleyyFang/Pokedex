//
//  APIClient.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/13/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import Foundation

protocol PokemonProtocol {
    func didUpdatePokemon(_ APIClient:APIClient,pokemonList:[PokemonModel])
    func responseError(error:Error)
}

struct APIClient {
    let Pokeurl = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    var delegate:PokemonProtocol?
    
    func fetchData(){
        print("Start fetching data!")
        if let url = URL(string:Pokeurl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data,response,error) in
                if error != nil{
                    self.delegate?.responseError(error:error!)
                    return
                }
                if let safeData = data?.parseData(removeString: "null,") { //the API JSON has the first attribute NULL
                    if let modelList = self.parseJSON(pokemon: safeData){
                        self.delegate?.didUpdatePokemon(self,pokemonList: modelList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(pokemon:Data) ->[PokemonModel]?{
        print("start parsing JSON")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Pokemon].self, from: pokemon)
            var pokelist: [PokemonModel] = []
            for i in 0 ... 50 { //decodedData.count = 151
                let name=decodedData[i].name
                let imageUrl = decodedData[i].imageUrl
                let description = decodedData[i].description
                let height = decodedData[i].height
                let weight = decodedData[i].weight
                let attack = decodedData[i].attack
                let type = decodedData[i].type
                let pokemodel = PokemonModel(name: name ?? "", imageUrl: imageUrl ?? "", description: description ?? "", height: height ?? 0, weight: weight ?? 0, attack: attack ?? 0, type: type ?? "")
                pokelist.append(pokemodel)
            }
             return pokelist

        }catch {
            delegate?.responseError(error: error)
            return (nil)
        }
    }
}

extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
