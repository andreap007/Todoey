//
//  Item.swift
//  Todoey
//
//  Created by Andrea on 09/06/2019.
//  Copyright © 2019 Andrea P. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}