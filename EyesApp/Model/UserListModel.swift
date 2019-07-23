//
//  UserList.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import CoreData

struct UserListModel: CoreServiceCodable {
    var users: [User]?
}

@objc(User)
final class User: NSManagedObject, CoreServiceCodable {
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var createdDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName
        case profileImage
        case createdDate
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
        self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userName, forKey: .userName)
        try container.encode(name, forKey: .name)
        try container.encode(profileImage, forKey: .profileImage)
        try container.encode(createdDate, forKey: .createdDate)
    }
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
