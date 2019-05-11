//
//  ViewController.swift
//  swifty_companion
//
//  Created by Denis DEHTYARENKO on 4/24/19.
//  Copyright © 2019 Denis DEHTYARENKO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ViewController: UIViewController {


    
    @IBOutlet weak var image: UIImageView!
     
    @IBOutlet weak var loginlabel: UITextField!
    
    @IBAction func loginbuttton(_ sender: Any) {
        
        if (loginlabel.text?.isEmpty)! { return }
        if loginlabel.text?.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            print("inapropriate characters") }
        else {
                get_data(login: loginlabel.text!)
            }
    }
    
    func get_data(login: String) {
        
        print(login)
        guard let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + login) else { return }
        let bearer = "Bearer " + gData.global.token
        var request = URLRequest(url: userUrl)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                student.phone = ""
                if let phone = json["phone"].string {
                    student.phone = phone
                    print(phone)
                }
                student.wallet = 0
                if let walet = json["wallet"].int {
                    student.wallet = walet
                    print(walet)
                }
                student.displayname = ""
                if let displayname = json["displayname"].string {
                    student.displayname = displayname
                    print(displayname)
                }
                student.email = ""
                if let email = json["email"].string {
                    student.email = email
                    print(email)
                }
                student.image_url = ""
                if let image_url = json["image_url"].string {
                    student.image_url = image_url
                    print(image_url)
                }
                student.location = ""
                if let location = json["location"].string {
                    student.location = location
                    print(location)
                }
                if let login = json["login"].string {
                    student.login = login
                    print(login)
                }
                if let pool_year = json["pool_year"].string {
                    student.pool_year = pool_year
                    print(pool_year)
                }
                if let pool_month = json["pool_month"].string {
                    student.pool_month = pool_month
                    print(pool_month)
                }
                student.correction_point = 0
                if let correction_point = json["correction_point"].int {
                    student.correction_point = correction_point
                    print(correction_point)
                }
                if let level = json["cursus_users"][0]["level"].double {
                    student.level = level
                   print(level)
                }
                if let campus_country = json["campus"][0]["country"].string {
                    student.campus_country = campus_country
                    print(campus_country)
                }
                if let campus_cite = json["campus"][0]["city"].string {
                    student.campus_city = campus_cite
                    print(campus_cite)
                }
                student.skills.removeAll()
                if let skills = json["cursus_users"][0]["skills"].array {
                    for i in skills {
                        if let level = i["level"].float {
                            student.skills.append((i["name"].string!, level))
                        }
                    }
                }
                student.projects_users_sacces.removeAll()
                student.projects_users_loading.removeAll()
                student.projects_users_fail.removeAll()
                if let projects_users = json["projects_users"].array {
                    for i in projects_users {

                        if i["final_mark"].int == nil {
                            student.projects_users_loading.append((i["project"]["name"].string!, i["project"]["slug"].string!, i["status"].string!, i["validated?"].bool, 0)) }
                        else {
                                if i["validated?"].bool! == true && i["final_mark"].int != nil && i["final_mark"].int! > 0 {
                                    student.projects_users_sacces.append((i["project"]["name"].string!, i["project"]["slug"].string!, i["status"].string!, i["validated?"].bool, i["final_mark"].int)) }
                                else if i["validated?"].bool! != true {
                                    student.projects_users_fail.append((i["project"]["name"].string!, i["project"]["slug"].string!, i["status"].string!, i["validated?"].bool, i["final_mark"].int)) }
                        }
                    }
                }
                self.performSegue(withIdentifier: "seque2", sender: self)
            case .failure(let error):
                print(error)
                print(" FAILED ")
            }
        }
    }
    
    
    func get_token() {
        
        let url = "https://api.intra.42.fr/oauth/token"
        let config = [
            "grant_type": "client_credentials",
            "client_id": gData.global.uid,
            "client_secret": gData.global.secret]
        let verify = UserDefaults.standard.object(forKey: "token")
        if verify == nil {
            Alamofire.request(url, method: .post, parameters: config).validate().responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let token = json["access_token"].string {
                        gData.global.token = token
                        print(gData.global.token)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        else {
        }
    }
    

    @IBAction func enterPressed(_ sender: Any) {
        print(2)
        loginbuttton(sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Unit students"
    
        get_token()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

