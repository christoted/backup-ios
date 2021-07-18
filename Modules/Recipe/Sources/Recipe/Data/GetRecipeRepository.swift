//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Core
import Combine

public struct GetCategoriesRepository<RecipeLocalDataSource: LocaleDataSource, RemoteDataSource: DataSource, Transformer: Mapper>: Repository where
    
    //2
    RecipeLocalDataSource.Response == RecipeModuleMenuEntity,
    RemoteDataSource.Response == [RandomMenuResponse],
    Transformer.Response == [RandomMenuResponse],
    Transformer.Entity == [RecipeModuleMenuEntity],
    Transformer.Domain == [RecipeDomainModel] {
    
    
    public typealias Request = Any    
    public typealias Response = [RecipeDomainModel]
    
    private let _localeDataSource: RecipeLocalDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init( localDataSource: RecipeLocalDataSource,
                 remoteDataSource: RemoteDataSource,
                 mapper: Transformer) {
        
        _localeDataSource = localDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[RecipeDomainModel], Error> {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[RecipeDomainModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map {
                            _mapper.transformResponseToEntity(response: $0)
                        }
                        .flatMap {
                            _localeDataSource.add(entities: $0)
                        }
                        .filter{ $0}
                        .flatMap { _ in _localeDataSource.list(request: nil)
                            .map {
                                _mapper.transformEntityToDomain(entity: $0)
                            }
                            
                        }.eraseToAnyPublisher()
                    
                } else {
                    return _localeDataSource.list(request: nil).map {
                        _mapper.transformEntityToDomain(entity: $0)
                    }.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

