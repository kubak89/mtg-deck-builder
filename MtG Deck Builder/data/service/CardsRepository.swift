//
//  CardsService.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 07/06/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class CardsRepository {
    private let BASE_URL = "https://api.magicthegathering.io/v1"
    private let CARDS_URL = "/cards"
    
    func rxSearchCards(name: String) -> Single<[Card]> {
        return Single<[Card]>.create { singleEmitter in
            let request = AF.request(self.buildCardsUrl()).validate(statusCode: 200..<299).responseJSON{ response in
                do {
                    let decoder = JSONDecoder()
                    if let data = response.data {
                        let cardResponse = try decoder.decode(CardsResponse.self, from: data)
                        singleEmitter(SingleEvent.success(cardResponse.cards))
                    }
                } catch {
                    print(error)
                    singleEmitter(SingleEvent.error(error))
                }
            }
            
            return Disposables.create { request.cancel()  }
        }
    }
    
    func buildCardsUrl() -> String {
        return self.buildUrl(endpointPath: self.CARDS_URL)
    }
    
    private func buildUrl(endpointPath: String) -> String {
        return BASE_URL + endpointPath
    }
    
}
