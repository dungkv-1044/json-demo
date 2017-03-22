//
//  Person.swift
//  JSON-Demo
//
//  Created by Khuat Van Dung on 3/23/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation

class Person {
    var name: String = ""
    var dob: String = ""
    var imgUrl : String = ""
    init(dictionary: Dictionary<AnyHashable,Any>) {
        self.name = dictionary["name"] as? String ?? ""
        self.dob = dictionary["dob"] as? String ?? ""
        self.imgUrl = dictionary["image"] as? String ?? ""
    }
}
