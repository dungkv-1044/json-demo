//
//  DataService.swift
//  JSON-Demo
//
//  Created by Khuat Van Dung on 3/20/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation

class DataService {
    static let shared = DataService()
    let URL_String = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    private var _person: [Person]! {
        didSet {
            NotificationCenter.default.post(name: NotificationKey.didSetPersons, object: nil)
        }
    }
    
    var person : [Person] {
        set {
            _person = newValue
        }
        get {
            if _person == nil {
                downloadJSONWithUrl()
                
            }
              
            return _person
        }
    }
    
    func downloadJSONWithUrl() {
        _person = []
        guard let url = URL(string: URL_String) else { return}
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? Dictionary<AnyHashable,Any> else  { return }
            print(jsonObject)
            guard let actors = jsonObject["actors"] as? Array<Any>  else { return }
            var result : [Person] = []
            for actor in actors {
                if let actorDict = actor as? Dictionary<AnyHashable,Any> {
                    let person = Person(dictionary: actorDict)
                    result.append(person)
                }
            }
            self._person = result
        }).resume()
       
    }
    
}


