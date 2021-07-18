//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
