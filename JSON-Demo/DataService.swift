//
//  DataService.swift
//  JSON-Demo
//
//  Created by Khuat Van Dung on 3/20/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit

class DataService {
    static let shared = DataService()
    let URL_String = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"

    var _person: [Person] = []
  
    var person : [Person] {
        set {
            _person = newValue
        }
        get {
            if _person.count == 0 {
                downloadJSONWithUrl()
            }
            return _person
        }
    }
  
    func downloadJSONWithUrl() {
        let url = NSURL(string: URL_String)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data,response,error) -> Void in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let actorArr = jsonObject!.value(forKey: "actors") as? NSArray {
                    for actor in actorArr {
                        if let actorDict = actor as? NSDictionary {
                            let name = actorDict.value(forKey: "name") as? String
                            let dob = actorDict.value(forKey: "dob") as? String
                            let photo = actorDict.value(forKey: "image") as? String
                            let p = Person(name: name!, dob: dob!, img: photo!)
                            self._person.append(p)
                        }
                    }
                }
            }
        }).resume()
    }

}

class Person {
    var name: String!
    var dob: String!
    var imgUrl : String!
    init(name:String,dob:String,img:String) {
        self.name = name
        self.dob = dob
        self.imgUrl = img
    }
}
