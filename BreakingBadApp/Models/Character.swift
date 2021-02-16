//
//  Actor.swift
//  BreakingBadApp
//
//  Created by Stefan Minchevski on 10/12/20.
//

/*
 {
     "char_id": 1,
     "name": "Walter White",
     "birthday": "09-07-1958",
     "occupation": [
       "High School Chemistry Teacher",
       "Meth King Pin"
     ],
     "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
     "status": "Presumed dead",
     "nickname": "Heisenberg",
     "appearance": [
       1,
       2,
       3,
       4,
       5
     ],
     "portrayed": "Bryan Cranston",
     "category": "Breaking Bad",
     "better_call_saul_appearance": [
       1,
       2,
       3,
       4
     ]
   },
 */

import UIKit

struct Character: Decodable {
    var charId: Int
    var name: String?
    var birthday: String?
    var occupation: [String]?
    var img: String?
    var status: String?
    var nickname: String?
    var appearance: [Int]?
    var portrayed: String?
    var category: String?
    var betterCallSaulAppearance: [Int]?
    var quote: [Quotes]?
}


struct Quotes: Decodable{
  var quote_id: Int
  var quote: String?
  var author: String?
  var series: String?
}
