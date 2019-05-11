//
//  SecondViewController.swift
//  swifty_companion
//
//  Created by Denis DEHTYARENKO on 4/26/19.
//  Copyright © 2019 Denis DEHTYARENKO. All rights reserved.
//

import UIKit
import Charts
import DDSpiderChart

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var subjects:[(String)] = [(String)]()
    var project : Int = 0
    var style_pro : Int = 0
    
//    typealias Decoration<T> = (T) -> Void
//    let decoration: Decoration<UIView>
    
    var projects_users: [(String, String, String, Bool?, Int?)] = student.projects_users_sacces
  
    @IBAction func style(_ sender: UIButton) {
        
        if style_pro == 0 {
           style_pro = 1
            sender.setTitle("☀", for: .normal)}
        else {
            style_pro = 0
            sender.setTitle("☾", for: .normal)}
        viewDidLoad()
    }
    
    @IBOutlet weak var tabbar: UITabBar!
    
    @IBOutlet var lables: [UILabel]!
    @IBOutlet var Button: [UIButton]!
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var spiderChartView: DDSpiderChartView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var levellebel: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var nick: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var tel: UILabel!
    
    @IBOutlet weak var point: UILabel!
    
    @IBOutlet weak var walet: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var gorizontChart: HorizontalBarChartView!
    
    @IBOutlet weak var back: UIImageView!
    
    @IBOutlet weak var year: UILabel!
    
    func student_photo() {
        let url_image = URL(string:student.image_url!)

        URLSession.shared.dataTask(with: url_image!) { (data, response, error) in
            if error != nil {
               print(" ERROR ")
            }
            DispatchQueue.main.async {
                self.photo.image = UIImage(data: data!)
                self.photo.layer.cornerRadius = self.photo.frame.size.width / 2
                self.photo.clipsToBounds = true
            }
            }.resume()
    }
    
    func student_info_all() {
        
        if student.displayname != nil{
            nick.text = "✅ " + student.login!
        }
        if student.pool_year != nil {
            year.text = String(describing: student.pool_year!)
        }
        if student.email != nil{
            email.text = "@" + student.email!
        }
        if student.phone != nil{
            tel.text = "📱 " + student.phone!
        }
        if student.correction_point != nil{
            point.text = "Evaluation points : " + String(student.correction_point) + " ☕"
        }
        if student.wallet != nil{
            walet.text = "Wallet: " + String(student.wallet!) + " ₴"
        }
        if student.location != "" {
            location.text = "💡 " + student.location! + "   ♻️  " + student.campus_city! }
        else {
            location.text = "🐾 " + "Unavailable" + "   ♻️  " + student.campus_city! }
        self.title = student.displayname
        
    }
    
    @IBAction func good(_ sender: Any) {
        project = 0
        projects_users = student.projects_users_sacces
        self.tableView.reloadData()
    }
    
    @IBAction func lost(_ sender: Any) {
        project = 1
        projects_users = student.projects_users_fail
        self.tableView.reloadData()
        
    }
    
    @IBAction func wait(_ sender: Any) {
        project = 2
        projects_users = student.projects_users_loading
        self.tableView.reloadData()
    }
    
    func level_bar() {
        
        gorizontChart.drawBarShadowEnabled = true
        gorizontChart.drawValueAboveBarEnabled = true
        gorizontChart.maxVisibleCount = 100
        gorizontChart.chartDescription?.text = ""
        gorizontChart.scaleXEnabled = false
        gorizontChart.scaleYEnabled = false
        gorizontChart.dragEnabled = false
        let xAxis  = gorizontChart.xAxis
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        
        let leftAxis = gorizontChart.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.0;
        leftAxis.axisMaximum = 100;
        leftAxis.drawLabelsEnabled = false
        
        let rightAxis = gorizontChart.rightAxis
        rightAxis.enabled = false
        
        let l = gorizontChart.legend
        l.enabled =  false
        
        var yVals = [BarChartDataEntry]()
        
        var lev = student.level! - Double(Int(student.level!))
        lev = lev * 100
        lev = round(lev)
        let levell = Int(lev)
        
        yVals.append(BarChartDataEntry(x: 0, y: Double(levell)))
        
        var set1 : BarChartDataSet!
        
        if let count = gorizontChart.data?.dataSetCount, count > 0 {
            set1 = gorizontChart.data?.dataSets[0] as? BarChartDataSet
            set1.values = yVals
            gorizontChart.data?.notifyDataChanged()
            gorizontChart.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(values: yVals, label: nil)
            set1.drawValuesEnabled = false
            var dataSets = [BarChartDataSet]()
            set1.colors = [NSUIColor(red: 0.1, green: 0.7, blue: 0.6, alpha: 1.0)]
            dataSets.append(set1)
            let data = BarChartData(dataSets: dataSets)
            gorizontChart.data = data
            gorizontChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutQuart)
        }
        levellebel.text = "level " + String(Int(student.level!)) + " - " + String(levell) + "%"
        
    }
    
     func student_skils() {
     
        student.skills = student.skills.sorted(by: { $0 > $1 })
        spiderChartView.color = .gray
        var val : [Float] = []
        var name : [String] = []
    
        for i in 0..<student.skills.count {
            
            name.append(student.skills[i].0)
            val.append(student.skills[i].1 / 20.0)
        }
        spiderChartView.axes = name.map { attributedAxisLabel($0) }
        spiderChartView.addDataSet(values:val, color: UIColor(red: 0.1, green: 0.7, blue: 0.6, alpha: 1.0))
        spiderChartView.backgroundColor = UIColor.clear
        spiderChartView.circleCount = 4
        spiderChartView.circleGap = 30
    }
    
    func attributedAxisLabel(_ label: String) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        
        let attributedString = NSMutableAttributedString()
        if self.style_pro == 0 {
            attributedString.append(NSAttributedString(string: label, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "ArialMT", size: 8)!, NSAttributedStringKey.paragraphStyle: style])) }
        else {
            attributedString.append(NSAttributedString(string: label, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "ArialMT", size: 8)!, NSAttributedStringKey.paragraphStyle: style])) }
        return attributedString
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects_users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Table
        cell.project.text = projects_users[indexPath.row].0
        if  project == 0{
            cell.score.text = "☺️" + String(describing: projects_users[indexPath.row].4!)
            cell.project.textColor = UIColor(red: 0.1, green: 0.7, blue: 0.6, alpha: 1.0)
            cell.score.textColor = UIColor(red: 0.1, green: 0.7, blue: 0.6, alpha: 1.0) }
        else if project == 1 {
            if projects_users[indexPath.row].4! == -42 {
                cell.score.text = "☔️" + String (describing: projects_users[indexPath.row].4!) }
            else {
                cell.score.text = "☹️" + String (describing: projects_users[indexPath.row].4!) }
            cell.project.textColor = UIColor.red
            cell.score.textColor = UIColor.red }
        else {
            cell.score.text = projects_users[indexPath.row].2
            cell.project.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
            cell.score.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0) }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    func student_info() {
        self.student_photo()
        self.student_info_all()
        if student.level != nil {
            self.level_bar() }
        if student.skills.count > 0 {
            self.student_skils() }
    }
    
    var tapGesture = UITapGestureRecognizer()
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        
        print(" Y O U ")
    }
    
    
    func addBackground() {
        if style_pro == 0 {
            back.image = UIImage(named: "white2")
            lables.map({$0.textColor = .black})
            Button.map({$0.backgroundColor = .white})
            
            self.tableView.backgroundColor = UIColor.white
            self.tabbar.backgroundImage = UIImage(named: "white2")
            self.scroll.backgroundColor = UIColor.white
            
            
        
            navigationController?.navigationBar.barTintColor = UIColor.white
            navigationController?.navigationBar.tintColor = UIColor.black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    
        }
        else {
            back.image = UIImage(named: "black2")
            lables.map({$0.textColor = .white})
            Button.map({$0.backgroundColor = .black})
            
            self.tableView.backgroundColor = UIColor.black
            self.tabbar.backgroundImage = UIImage(named: "black2")
            self.scroll.backgroundColor = UIColor.black
            
            navigationController?.navigationBar.barTintColor = UIColor.black
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    override func viewDidLoad() {

        self.addBackground()
        self.student_info()
        super.viewDidLoad()
        print ( "UPDATE" )
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        spiderChartView.addGestureRecognizer(tapGesture)
        spiderChartView.isUserInteractionEnabled = true
        
    }
    
}







