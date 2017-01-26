//
//  XMLPOrder.swift
//  XMLPractice
//
//  Created by Mac on 1/20/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import Fuzi
struct XMLPOrderItem
{
    var quantity: Int // no need (!). It will be initialised from controller
    var price : Double
    var nameItem:String
    var currency :String
}
class XMLPOrder: NSObject {
    var quantity: Int // no need (!). It will be initialised from controller
    var price : Double
    var nameItem:String
    var lastName:String
    var firstName:String
    var itemsArray = [XMLPOrderItem]()
    init(fromString fname: String,quantity:Int,nameItem:String,price:Double,lastName:String,itemArray:[XMLPOrderItem]) {
        self.firstName = fname
        self.quantity = quantity
        self.lastName = lastName
        self.price =  price
        self.nameItem = nameItem
        self.itemsArray = itemArray
        super.init()
    }
      convenience init(xmlDoc:XMLElement) {
      //right
  //      print(xmlDoc.children(tag: "customer").first?.children(tag: "emailCus").first?.stringValue)
   //wrong
   // print(xmlDoc.children(tag: "customer").first?.document.xpath("//firstName").first?.stringValue)

        
       
        var  itemsArray = [XMLPOrderItem]()
        
        for element in xmlDoc.children(tag: "item") {
            
            
            let newItem = XMLPOrderItem(quantity: element.children(tag: "quantity").first?.numberValue as! Int, price: element.children(tag: "price").first?.numberValue as! Double, nameItem: (element.children(tag: "nameItem").first?.stringValue)!,currency : (element.children(tag: "price").first?.attr("currency"))!)
            //print(element.children(tag: "nameItem").first?.stringValue)
     itemsArray.append(newItem)
        
        }
        let quantity: Int = Int((xmlDoc.children(tag: "item").first?.children(tag: "quantity").first?.numberValue)!) // no need (!). It will be initialised from controller
        let price : Double =  Double((xmlDoc.children(tag: "item").first?.children(tag: "price").first?.numberValue)!)

        let nameItem:String =  (xmlDoc.children(tag: "item").first?.children(tag: "nameItem").first?.stringValue)!

        let lastName:String = (xmlDoc.children(tag: "customer").first?.children(tag: "lastName").first?.stringValue)!
        let firstName:String = (xmlDoc.children(tag: "customer").first?.children(tag: "firstName").first?.stringValue)!
        self.init(fromString : firstName,quantity:quantity,nameItem:nameItem,price:price,lastName:lastName,itemArray:itemsArray)
    }
    convenience override init() {
           self.init(fromString : "asdfsa",quantity:-1,nameItem:"",price:-1,lastName:"",itemArray:[XMLPOrderItem]())
     //   self.init(fromString:"John") // calls above mentioned controller with default name
    }
    func calcuateTotalPrice()->Double
    {
        var cost = 0.0
        for item in self.itemsArray
        {
           let tempCost =  item.price * Double(item.quantity)
            cost += tempCost
        }
        
        return cost
    }
    func reportString()->String
    {
        var string = "@" +  self.firstName + " : " + String(self.calcuateTotalPrice()) + " "
   string +=   (self.itemsArray.first?.currency)!
        return string
        
    }
    
    
}
