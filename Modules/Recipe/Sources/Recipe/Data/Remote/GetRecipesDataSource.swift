//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetRecipesRemoteDataSource: DataSource {
    
    public typealias Request = Any
    
    public typealias Response = [RandomMenuResponse]
    
    private let _endPoint: String
    
    public init(endPoint: String) {
        self._endPoint = endPoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[RandomMenuResponse], Error> {
        return Future<[RandomMenuResponse], Error> { completion in
            if let url = URL(string: _endPoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: Responses.self) { (response) in
                        switch response.result {
                        case .success(let valueResponse):
                            completion(.success(valueResponse.result))
                            
                        case .failure:
                            completion(.failure(URLErrorFound.invalidResponse))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
