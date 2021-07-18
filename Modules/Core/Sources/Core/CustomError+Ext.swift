//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation

public enum URLErrorFound: LocalizedError {
    
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
    
}

public enum DatabaseError: LocalizedError {
    case databaseError
    case databaseInvalid
    
    public var errorDescription: String? {
        switch self {
        case DatabaseError.databaseError:
           return  "Database Error"
        case DatabaseError.databaseInvalid :
            return "Database Invalid"
        }
        
    }
    
}
