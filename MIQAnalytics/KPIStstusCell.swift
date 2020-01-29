//
//  KPIStstusCell.swift
//  googlMapTutuorial2
//
//  Created by Girish on 06/01/20.
//  Copyright © 2020 akhil. All rights reserved.
//

import UIKit
import Charts

class KPIStstusCell: UITableViewCell {
    
    
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints=false
        v.layer.borderWidth  = 0
        //  v.layer.borderColor = (UIColor.red as! CGColor)
        v.layer.cornerRadius = 0.25
        
        
        return v
    }()
    
    public let onTargetLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.clear
        let underlineAttriString = NSAttributedString(string:"On Target", attributes:
            [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        lbl.attributedText = underlineAttriString
        return lbl
    }()
    public let onTargetValueLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
       // lbl.text = "22"
        // lbl.layer.borderColor = UIColor(red:227/255, green:83/255, blue:86/255, alpha: 1).cgColor
        // lbl.layer.borderWidth = 1.0;
        //lbl.layer.cornerRadius = 12.5
          lbl.backgroundColor =  UIColor(red:64/255, green:136/255, blue:80/255, alpha: 1)
       
        //lbl.layer.borderColor = UIColor.black as? CGColor
        return lbl
        
    }()
    
    public let vulnerableLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.clear
        let underlineAttriString = NSAttributedString(string:"Vulnerable", attributes:
            [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        lbl.attributedText = underlineAttriString
        return lbl
    }()
    public let vulnerableValueLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
      //  lbl.text = "22"
        //lbl.layer.borderColor = UIColor(red:218/255, green:160/255, blue:58/255, alpha: 1).cgColor
        //lbl.layer.borderColor = UIColor.black.cgColor
        // lbl.layer.borderWidth = 1.0;
        //lbl.layer.cornerRadius = 12.5
        lbl.backgroundColor =  UIColor(red:218/255, green:160/255, blue:58/255, alpha: 1)
        //lbl.layer.borderColor = UIColor.black as? CGColor
        return lbl
    }()
    
    public let offTatgetLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        
        let underlineAttriString = NSAttributedString(string:"Off Target", attributes:
            [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        lbl.attributedText = underlineAttriString
        lbl.backgroundColor = UIColor.clear
        return lbl
    }()
    public let offTatgetValueLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
      //  lbl.text = "22"
        //lbl.layer.borderColor = UIColor(red:64/255, green:136/255, blue:80/255, alpha: 1).cgColor
        //  lbl.layer.borderColor = UIColor.black.cgColor
        //lbl.layer.borderWidth = 1.0;
        //lbl.layer.cornerRadius = 12.5
         lbl.backgroundColor = UIColor(red:227/255, green:83/255, blue:86/255, alpha: 1)
        //lbl.layer.borderColor = UIColor.black as? CGColor
        return lbl
    }()
    
    public let chart2 : PieChartView = {
        let piech = PieChartView()
        return piech
    }()
    
    
    var properties = ["United States","Mexico","Canada"]
    var values = [1000.0,2000.0,3000.0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        addSubview(containerView)
        addSubview(onTargetLabel)
        addSubview(onTargetValueLabel)
        addSubview(vulnerableLabel)
        addSubview(vulnerableValueLabel)
        addSubview(offTatgetValueLabel)
        addSubview(offTatgetLabel)
        
        addSubview(chart2)
        updateUII()
        
        
        
        var dietChart = PieChartView(frame: CGRect(x:0,y:0,width:250,height:250))
        dietChart.backgroundColor = .black
        
        // createPieChart(chart: dietChart,property: properties, value: values)
        
    }
    @objc func longLabelPressed(recognizer:UITapGestureRecognizer){
        if let label = recognizer.view as? UILabel {
            if recognizer.state == .began {
                label.textColor = UIColor.clear
            }
            if recognizer.state == .changed {
                label.textColor = UIColor.black
            }
            
            if recognizer.state == .ended {
                label.textColor = UIColor.gray
            }



        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    func updateCellContentt( categoryhealth : CategoryHealth)
    {
        var valuearray = [Int]()
        valuearray.append(categoryhealth.onTarget ?? 0)
        valuearray.append(categoryhealth.vulenrable ?? 0)
        valuearray.append(categoryhealth.offTarget ?? 0)
        
        var entries = [PieChartDataEntry]()
        for (index, value) in valuearray.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
           // entry.label = property[index]
            entries.append( entry)
        }
        
        let set = PieChartDataSet( entries: entries, label: nil)
        var colors = [UIColor.init(hexString: "#138b4a"),UIColor.init(hexString: "#e49e0d"),UIColor.init(hexString: "#f54450")]
        // set.colors = colors as! [NSUIColor]
        set.colors = colors as! [NSUIColor]
        
        let data = PieChartData(dataSet: set)
        chart2.data = data
        chart2.noDataText = "No data available"
        chart2.isUserInteractionEnabled = true
        chart2.backgroundColor = .clear
        let d = Description()
        d.text = ""
        chart2.chartDescription = d
        chart2.centerText = categoryhealth.categoryName?.capitalized
        
        onTargetLabel.text = "On Target"
        vulnerableLabel.text = "Vulnerable"
        // offTatgetLabel.text = "OFF-Target"
        let ontarget : Int = categoryhealth.onTarget ?? 0
        var ontargetmyString = String(ontarget)
        onTargetValueLabel.text = ontargetmyString
        onTargetValueLabel.accessibilityLabel = categoryhealth.categoryName! + "ontarget"
        
      
        let offtarget : Int = categoryhealth.offTarget ?? 0
        var offtargetmyString = String(offtarget)
        offTatgetValueLabel.text = offtargetmyString
        
        
        let vulenerable : Int = categoryhealth.vulenrable ?? 0
        var vulenerablemyString = String(vulenerable)
        vulnerableValueLabel.text = vulenerablemyString
        
        
        set.drawValuesEnabled = false
        chart2.drawEntryLabelsEnabled = false
       // offTatgetValueLabel.text = categoryhealth.offTarget
        //vulnerableValueLabel.text = categoryhealth.vulenrable
        
        
        //                   let attachment = NSTextAttachment()
        //                   attachment.image = UIImage(named: "download.jpeg")
        //                   let attachmentString = NSAttributedString(attachment: attachment)
        //                   let labelImg = NSMutableAttributedString(string: "")
        //                   labelImg.append(attachmentString)
        // chart2.centerAttributedText = labelImg
        chart2.holeColor = UIColor(red:255,green:255,blue:255,alpha:0.5)
        
    }
    
  //  func updateCellContentt(property:[String],value :[Double])
//    {
//        var entries = [PieChartDataEntry]()
//        for (index, value) in value.enumerated() {
//            let entry = PieChartDataEntry()
//            entry.y = value
//            entry.label = property[index]
//            entries.append( entry)
//        }
//
//        let set = PieChartDataSet( entries: entries, label: nil)
//        var colors = [UIColor.init(hexString: "#138b4a"),UIColor.init(hexString: "#f54450"),UIColor.init(hexString: "#e49e0d")]
//        // set.colors = colors as! [NSUIColor]
//        set.colors = colors as! [NSUIColor]
//        let data = PieChartData(dataSet: set)
//        chart2.data = data
//        chart2.noDataText = "No data available"
//        chart2.isUserInteractionEnabled = true
//        chart2.backgroundColor = .clear
//        let d = Description()
//        d.text = ""
//        chart2.chartDescription = d
//        chart2.centerText = "Saftey"
//
//        onTargetLabel.text = "On Target"
//        vulnerableLabel.text = "Vulnerable"
//        // offTatgetLabel.text = "OFF-Target"
//
//
//        //                   let attachment = NSTextAttachment()
//        //                   attachment.image = UIImage(named: "download.jpeg")
//        //                   let attachmentString = NSAttributedString(attachment: attachment)
//        //                   let labelImg = NSMutableAttributedString(string: "")
//        //                   labelImg.append(attachmentString)
//        // chart2.centerAttributedText = labelImg
//        chart2.holeColor = UIColor(red:255,green:255,blue:255,alpha:0.5)
//
//    }
    func createPieChart(chart:PieChartView,property:[String],value:[Double])  {
        var entries = [PieChartDataEntry]()
        for (index, value) in value.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = property[index]
            entries.append( entry)
        }
        
        let set = PieChartDataSet( entries: entries, label: nil)
        
        var colors = [UIColor.green,UIColor.red,UIColor(red:218/255 ,green:165/255 ,blue:32/255,alpha:1.0 ),UIColor.blue,UIColor.red]
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        chart.isUserInteractionEnabled = true
        chart.backgroundColor = .clear
        let d = Description()
        d.text = ""
        chart.chartDescription = d
        chart.centerText = "MIQ"
        
        //            let attachment = NSTextAttachment()
        //            attachment.image = UIImage(named: "download.jpeg")
        //            let attachmentString = NSAttributedString(attachment: attachment)
        //            let labelImg = NSMutableAttributedString(string: "")
        //            labelImg.append(attachmentString)
        //            chart.centerAttributedText = labelImg
        
        chart.holeColor = UIColor(red:255,green:255,blue:255,alpha:0.5)
        self.addSubview(chart)
        
    }
    
    func updateUII(){
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longLabelPressed))
        tapGestureRecognizer.minimumPressDuration = 0.001
//        let longgestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("longLabelPressed:"))
        
        onTargetLabel.isUserInteractionEnabled = true
        onTargetLabel.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: self.frame.width, height: self.frame.height, enableInsets: true)
        
        chart2.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 200, height: 200, enableInsets: true)
        
        onTargetValueLabel.anchor(top: chart2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
        
        onTargetValueLabel.layer.masksToBounds = true
        onTargetValueLabel.layer.cornerRadius = 25/2
        
        onTargetLabel.anchor(top: chart2.bottomAnchor, left: onTargetValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 5, paddingRight: 5, width: 90, height: 25, enableInsets: true)
        
        vulnerableValueLabel.anchor(top: chart2.bottomAnchor, left: onTargetLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
        vulnerableValueLabel.layer.masksToBounds = true
        vulnerableValueLabel.layer.cornerRadius = 25/2
        
        vulnerableLabel.anchor(top: chart2.bottomAnchor, left: vulnerableValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 5, paddingRight: 5, width: 100, height: 25, enableInsets: true)
        
        //            vulnerableValueLabel.layer.masksToBounds = true
        //            vulnerableValueLabel.layer.cornerRadius = 25/2
        //
         vulnerableLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        offTatgetValueLabel.anchor(top: chart2.bottomAnchor, left: vulnerableLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
        
        offTatgetValueLabel.layer.masksToBounds = true
        offTatgetValueLabel.layer.cornerRadius = 25/2
        
        offTatgetLabel.anchor(top: chart2.bottomAnchor, left: offTatgetValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 5, paddingRight: 15, width: 100, height: 25, enableInsets: true)
        
        
    }
    
}


