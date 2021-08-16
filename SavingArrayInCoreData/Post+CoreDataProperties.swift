//
//  Post+CoreDataProperties.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/17.
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
    @NSManaged public var place: String?
    @NSManaged public var images: [UIImage]?

}

extension Post : Identifiable {

}
