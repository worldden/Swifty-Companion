//
//  student.swift
//  swifty_companion
//
//  Created by Denis DEHTYARENKO on 4/25/19.
//  Copyright © 2019 Denis DEHTYARENKO. All rights reserved.
//

import Foundation
import UIKit

struct student {
    static var phone:String?
    static var wallet:Int?
    static var displayname:String?
    static var image_url:String?
    static var location:String?
    static var pool_year:String?
    static var pool_month:String?
    static var campus_city:String?
    static var campus_country:String?
    static var correction_point:Int!
    static var level:Double?
    static var email:String?
    static var login:String?
    
    static var skills: [(String, Float)] = [(String, Float)]()
  //  static var projects_users: [(String, String, String, Bool?, Int?)] = [(String, String, String, Bool?, Int?)]()
    
    static var projects_users_sacces: [(String, String, String, Bool?, Int?)] = [(String, String, String, Bool?, Int?)]()
    static var projects_users_loading: [(String, String, String, Bool?, Int?)] = [(String, String, String, Bool?, Int?)]()
    static var projects_users_fail: [(String, String, String, Bool?, Int?)] = [(String, String, String, Bool?, Int?)]()
}
