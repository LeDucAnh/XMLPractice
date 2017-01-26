//
//  XMLPOrder.swift
//  XMLPractice
//
//  Created by Mac on 1/20/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import Fuzi

class XMLPOrder: NSObject {
    var quantity: Int // no need (!). It will be initialised from controller
    var price : Double
    var nameItem:String
    var lastName:String
    var firstName:String
    init(fromString fname: String,quantity:Int,nameItem:String,price:Double,lastName:String) {
        self.firstName = fname
        self.quantity = quantity
        self.lastName = lastName
        self.price =  price
        self.nameItem = nameItem
        super.init()
    }
      convenience init(xmlDoc:XMLElement) {
        let quantity: Int = Int((xmlDoc.document.xpath("//quantity").first?.numberValue)!) // no need (!). It will be initialised from controller
        let price : Double =  Double((xmlDoc.document.xpath("//price").first?.numberValue)!)

        let nameItem:String = (xmlDoc.document.xpath("//nameItem").first?.stringValue)!

        let lastName:String = (xmlDoc.document.xpath("//lastName").first?.stringValue)!
        let firstName:String = (xmlDoc.document.xpath("//firstName").first?.stringValue)!
    
       // for att in xmlDoc.attributes{
        
        //}

        
      //  print(element.document.xpath("//emailCus").first?.stringValue)
        

        self.init(fromString : firstName,quantity:quantity,nameItem:nameItem,price:price,lastName:lastName)
        ////   self.init(fromString:"John") // calls above mentioned controller with default name
    }

    convenience override init() {
           self.init(fromString : "asdfsa",quantity:-1,nameItem:"",price:-1,lastName:"")
     //   self.init(fromString:"John") // calls above mentioned controller with default name
    }

    
}
