//
//  ReadDatabse.swift
//  AquaponicMonitor
//
//  Created by user214468 on 4/6/22.
//

import Foundation
import Firebase
import FirebaseDatabase

class ReadDatabase {
    var value: String
    
    init(value: String) {
        self.value = value
    }
    func readFromDatabase(path: String) -> String {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(path).observe(.childChanged) { snapshot in
            if let temp = snapshot.value as? String{
                self.value = temp
            }
            
        }
        return self.value
    }
}
