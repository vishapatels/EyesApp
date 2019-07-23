//
//  CoreServiceCodable.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import CoreData

protocol CoreServiceCodable: Codable {}

extension CoreServiceCodable {
    
    public static func from<T>(data: Data, managedObjectContext: NSManagedObjectContext? = nil) -> T? where T: Codable {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let decoder = JSONDecoder()
            if let managedObjectContext = managedObjectContext {
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            }
            let decodedItem =  try decoder.decode(T.self, from: data)
            try managedObjectContext?.save()
            return decodedItem
        } catch let ex {
            print("Unable to decode \(T.self): \(ex.localizedDescription)")
        }
        
        return nil
    }
    
    public static func arrayFrom<T>(data: Data, managedObjectContext: NSManagedObjectContext? = nil) -> [T]? where T: Codable {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let decoder = JSONDecoder()
            if let managedObjectContext = managedObjectContext {
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            }
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let decodedItems =  try decoder.decode([T].self, from: data)
            try managedObjectContext?.save()
            return decodedItems
           // return try JSONDecoder().decode([T].self, from: data)
        } catch let ex {
            print("Unable to decode array \(T.self): \(ex.localizedDescription)")
        }
        
        return nil
    }
    
    var dictionary: [String: Any] {
        do {
            guard let data = data else { return [:] }
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
        } catch let ex {
            print("Unable to encode \(self): \(ex.localizedDescription)")
        }
        return [:]
    }
    
    public var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch let ex {
            print("Unable to encode \(self): \(ex.localizedDescription)")
        }
        
        return nil
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

