//
//  NetworkHandlerSuccessMock.swift
//  PokemonAPI2Tests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation
@testable import PokemonAPI2
class NetworkHandlerMock: NetworkHandler {
    
    var data: Data? = nil
    var error: Error? = nil
    var response = URLResponse(url: URL(string: "www.test.com")!, mimeType: nil, expectedContentLength: 1, textEncodingName: nil)
    
    init(data: Data) {
        self.data = data
    }
    
    init(error: Error) {
        self.error = error
    }
    
    func request(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let data = self.data{
            print("Data")
            completionHandler(data,response,error)
        }
        
        if let error = self.error{
            print("Error")
            completionHandler(data,response,error)
        }
    }
    
}
