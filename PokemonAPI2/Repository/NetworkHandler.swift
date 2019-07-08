//
//  NetworkHandler.swift
//  PokemonAPI2
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

protocol NetworkHandler {
    func request(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
