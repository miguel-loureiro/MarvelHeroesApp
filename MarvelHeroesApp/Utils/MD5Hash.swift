//
//  MD5Hash.swift
//  MarvelHeroesApp
//
//  Created by António Loureiro on 09/12/2022.
//

import Foundation
import CryptoKit

struct MD5Hash {
    
    //    MARK: Internal
    
    func generate() -> String {
        if let stringToDigest = (Constants.API.timeStamp + Constants.API.privateKey +
                                 Constants.API.publicKey).data(using: .utf8) {
            let digest = Insecure.MD5.hash(data: stringToDigest)
            
            return digest.map {
                String(format: "%02hhx", $0)
            }.joined()
        }
        return ""
    }
}
