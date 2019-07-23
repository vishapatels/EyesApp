//
//  UserDetailModel.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import CoreData

struct UserDetailModel: CoreServiceCodable {
    let content: [Content]?
}

@objc(Content)

final class Content: NSManagedObject, CoreServiceCodable {
    
    @NSManaged public var height: Int64
    @NSManaged public var id: Int64
    @NSManaged public var type: String?
    @NSManaged public var width: Int64
    @NSManaged public var data: String?
    @NSManaged public var createdDate: String?
    @NSManaged public var userId: Int64
    
    enum CodingKeys: String, CodingKey {
        case id, type, width, height, data, createdDate, userId
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Content", in: managedObjectContext) else {
                fatalError("Failed to decode Content")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
        self.userId = try container.decodeIfPresent(Int64.self, forKey: .userId) ?? 0
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        self.height = try container.decodeIfPresent(Int64.self, forKey: .height) ?? 0
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.width = try container.decodeIfPresent(Int64.self, forKey: .width) ?? 0
        self.data = try container.decodeIfPresent(String.self, forKey: .data)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(height, forKey: .height)
        try container.encode(type, forKey: .type)
        try container.encode(width, forKey: .width)
        try container.encode(data, forKey: .data)
    }
    
}
