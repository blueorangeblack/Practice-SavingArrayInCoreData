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

    @NSManaged public var image: [UIImage]?
    @NSManaged public var date: Date?
    @NSManaged public var place: String?
    @NSManaged public var aromasAndFlavors: [String]?
    @NSManaged public var alcoholContent: Float
    @NSManaged public var price: Int32
    @NSManaged public var rating: Int16

}

extension Post : Identifiable {

}
