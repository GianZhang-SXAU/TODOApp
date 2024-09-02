//
//  TODOitem.swift
//  TODOAPP
//
//  Created by gian on 2023/10/17.
//

import UIKit

class TODOitem: NSObject,Encodable,Decodable {
    var title:String
    var isCheaked : Bool
    
    init(title:String,isCheaked:Bool){
        self.isCheaked = isCheaked
        self.title = title
    }
    
    
}
