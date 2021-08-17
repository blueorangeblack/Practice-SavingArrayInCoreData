//
//  Post+CoreDataProperties.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/18.
//
//

import Foundation
import CoreData
import UIKit

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var aromas: [String]?
    @NSManaged public var images: [UIImage]?
    @NSManaged public var place: String?

}

extension Post : Identifiable {

}
