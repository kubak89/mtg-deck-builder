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

class CardsService {
    private let BASE_URL = "https://api.magicthegathering.io/v1"
    private let CARDS_URL = "/cards"
    
    func searchCards(name: String, responseHandler: @escaping ([Card]) -> Void, errorHandler: @escaping (Error) -> Void) {
        AF.request(buildUrl(endpointPath: CARDS_URL)).responseJSON{ response in
            do {
                let decoder = JSONDecoder()
                if let data = response.data {
                    let cardResponse = try decoder.decode(CardsResponse.self, from: data)
                    responseHandler(cardResponse.cards)
                }
            } catch {
                print(error)
                errorHandler(error)
            }
        }
    }
    
    private func buildUrl(endpointPath: String) -> String {
        return BASE_URL + endpointPath
    }
    
}
