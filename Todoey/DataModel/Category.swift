//
//  Category.swift
//  Todoey
//
//  Created by Andrea on 09/06/2019.
//  Copyright © 2019 Andrea P. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
