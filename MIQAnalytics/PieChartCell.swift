//
//  PieChartCell.swift
//  googlMapTutuorial2
//
//  Created by Girish on 03/01/20.

//

import UIKit
import Charts

class PieChartCell: UITableViewCell {

//     var colors = [UIColor.init(hexString: "#138b4a"),UIColor.init(hexString: "#f54450"),UIColor.init(hexString: "#e49e0d")]

let containerView: UIView = {
       let v=UIView()
       v.backgroundColor = UIColor.black
       v.translatesAutoresizingMaskIntoConstraints=false
       //v.layer.borderWidth  = 2.0
       //  v.layer.borderColor = (UIColor.red as! CGColor)
       v.layer.cornerRadius = 0.25
       
       
       return v
   }()
public let topLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 8)
    lbl.textAlignment = .center
    lbl.layer.cornerRadius = 0.5
    lbl.backgroundColor = UIColor.init(hexString: "#2AC1C9")
    lbl.text = "KPI Quick lookup Monitor"
    return lbl
}()

public let onTargetLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 14)
    lbl.textAlignment = .center
    lbl.backgroundColor = UIColor.init(hexString: "#138b4a")
    return lbl
}()
public let onTargetValueLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textAlignment = .center
    lbl.text = "22"
     lbl.layer.borderColor = UIColor(red:64/255, green:136/255, blue:80/255, alpha: 1).cgColor
    
    //lbl.layer.borderColor = UIColor.orange.cgColor
    lbl.layer.borderWidth = 2.0;
    //lbl.layer.cornerRadius = 12.5
    lbl.backgroundColor = UIColor.black
    //lbl.layer.borderColor = UIColor.black as? CGColor
    return lbl
    
}()

public let vulnerableLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .white
     lbl.font = UIFont.systemFont(ofSize: 14)
     lbl.textAlignment = .center
     lbl.backgroundColor = UIColor.init(hexString: "#e49e0d")
     return lbl
}()
public let vulnerableValueLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textAlignment = .center
    lbl.text = "22"
     lbl.layer.borderColor = UIColor(red:218/255, green:160/255, blue:58/255, alpha: 1).cgColor
    //lbl.layer.borderColor = UIColor.green.cgColor
    lbl.layer.borderWidth = 2.0;
    //lbl.layer.cornerRadius = 12.5
    lbl.backgroundColor = UIColor.black
    //lbl.layer.borderColor = UIColor.black as? CGColor
    return lbl
}()

public let offTatgetLabel : UILabel = {
    let lbl = UILabel()
                lbl.textColor = .white
                lbl.font = UIFont.systemFont(ofSize: 14)
                lbl.textAlignment = .center
//        let underlineAttriString = NSAttributedString(string:"OFF-Target", attributes:
//            [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
//
//        lbl.attributedText = underlineAttriString
                lbl.backgroundColor = UIColor.init(hexString: "#f54450")
                return lbl
}()
public let offTatgetValueLabel : UILabel = {
   let lbl = UILabel()
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textAlignment = .center
    lbl.text = "22"
     lbl.layer.borderColor = UIColor(red:227/255, green:83/255, blue:86/255, alpha: 1).cgColor
    //lbl.layer.borderColor = UIColor.black.cgColor
    lbl.layer.borderWidth = 2.0;
    //lbl.layer.cornerRadius = 12.5
    lbl.backgroundColor = UIColor.black
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
    addSubview(topLabel)
    addSubview(onTargetLabel)
    addSubview(onTargetValueLabel)
    addSubview(vulnerableLabel)
    addSubview(vulnerableValueLabel)
    addSubview(offTatgetLabel)
    addSubview(offTatgetValueLabel)
    addSubview(chart2)
    
    updateUII()
    var dietChart = PieChartView(frame: CGRect(x:0,y:0,width:400,height:400))
    dietChart.backgroundColor = .black

  // createPieChart(chart: dietChart,property: properties, value: values)

}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
   // func updateCellContentt(property:[String],value :[Double] , health : Health)
//    {
//        var entries = [PieChartDataEntry]()
//               for (index, value) in value.enumerated() {
//                   let entry = PieChartDataEntry()
//                   entry.y = value
//                   entry.label = property[index]
//                   entries.append( entry)
//               }
//
//               let set = PieChartDataSet( entries: entries, label: nil)
//        var colors = [UIColor.init(hexString: "#138b4a"),UIColor.init(hexString: "#f54450"),UIColor.init(hexString: "#e49e0d")]
//        set.colors = colors as! [NSUIColor]
//               let data = PieChartData(dataSet: set)
//               chart2.data = data
//               chart2.noDataText = "No data available"
//               chart2.isUserInteractionEnabled = true
//               chart2.backgroundColor = .clear
//               let d = Description()
//               d.text = ""
//               chart2.chartDescription = d
//               chart2.centerText = "MIQ"
//
//
//        let greenColor = UIColor(red: 10/255, green: 190/255, blue: 50/255, alpha: 1)
//        // create the attributed colour
//        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.white];
//        // create the attributed string
//        let attributedString = NSAttributedString(string: "22 KPI", attributes: attributedStringColor)
//        // Set the label
//        chart2.centerAttributedText = attributedString
//
//
//        onTargetLabel.text = "On-Target"
//        vulnerableLabel.text = "Vulnerable"
//        offTatgetLabel.text = "Off-Target"
//
//        let circleColor = UIColor.black
//        let textColor = UIColor.white
//
//
//
//
//        //
//
//
//
//    //                   let attachment = NSTextAttachment()
//    //                   attachment.image = UIImage(named: "download.jpeg")
//    //                   let attachmentString = NSAttributedString(attachment: attachment)
//    //                   let labelImg = NSMutableAttributedString(string: "")
//    //                   labelImg.append(attachmentString)
//    //               chart2.centerAttributedText = labelImg
//        chart2.holeColor = UIColor.init(hexString: "#070806")
//
//    }


    func updateCellContentt( categoryhealth : Health)
       {
        
        var percentagearray = self.convertnumbertopercentage(first: Double(categoryhealth.onTarget ?? Int(0.0)), second: Double(categoryhealth.vulenrable ?? Int(0.0)), third: Double(categoryhealth.offTarget ?? Int(0.0)))
           var valuearray = [Double]()
        valuearray.append(percentagearray[0])
        valuearray.append(percentagearray[1])
        valuearray.append(percentagearray[2])
        
        
//           valuearray.append(categoryhealth.onTarget ?? 0)
//           valuearray.append(categoryhealth.vulenrable ?? 0)
//           valuearray.append(categoryhealth.offTarget ?? 0)
//
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
        
        let totalKPI : Int = categoryhealth.kpiTotalCount ?? 0
        var totalKPIStr = String(totalKPI)
           chart2.centerText = totalKPIStr + "KPI"
           
           onTargetLabel.text = "On Target"
           vulnerableLabel.text = "Vulnerable"
            offTatgetLabel.text = "OFF-Target"
           let ontarget : Int = categoryhealth.onTarget ?? 0
           var ontargetmyString = String(ontarget)
           onTargetValueLabel.text = ontargetmyString
           
         
           let offtarget : Int = categoryhealth.offTarget ?? 0
           var offtargetmyString = String(offtarget)
           offTatgetValueLabel.text = offtargetmyString
           
           
           let vulenerable : Int = categoryhealth.vulenrable ?? 0
           var vulenerablemyString = String(vulenerable)
           vulnerableValueLabel.text = vulenerablemyString
           
           
          // set.drawValuesEnabled = false
           chart2.drawEntryLabelsEnabled = false
        chart2.usePercentValuesEnabled = true
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
    
//func updateCellContentt(property:[String],value :[Double] )
//{
//    var entries = [PieChartDataEntry]()
//           for (index, value) in value.enumerated() {
//               let entry = PieChartDataEntry()
//               entry.y = value
//               entry.label = property[index]
//               entries.append( entry)
//           }
//
//           let set = PieChartDataSet( entries: entries, label: nil)
//    var colors = [UIColor.init(hexString: "#138b4a"),UIColor.init(hexString: "#f54450"),UIColor.init(hexString: "#e49e0d")]
//    set.colors = colors as! [NSUIColor]
//           let data = PieChartData(dataSet: set)
//           chart2.data = data
//           chart2.noDataText = "No data available"
//           chart2.isUserInteractionEnabled = true
//           chart2.backgroundColor = .clear
//           let d = Description()
//           d.text = ""
//           chart2.chartDescription = d
//           chart2.centerText = "MIQ"
//
//
//    let greenColor = UIColor(red: 10/255, green: 190/255, blue: 50/255, alpha: 1)
//    // create the attributed colour
//    let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.white];
//    // create the attributed string
//    let attributedString = NSAttributedString(string: "22 KPI", attributes: attributedStringColor)
//    // Set the label
//    chart2.centerAttributedText = attributedString
//
//
//    onTargetLabel.text = "On-Target"
//    vulnerableLabel.text = "Vulnerable"
//    offTatgetLabel.text = "Off-Target"
//
//    let circleColor = UIColor.black
//    let textColor = UIColor.white
//
//
//
//
//    //
//
//
//
////                   let attachment = NSTextAttachment()
////                   attachment.image = UIImage(named: "download.jpeg")
////                   let attachmentString = NSAttributedString(attachment: attachment)
////                   let labelImg = NSMutableAttributedString(string: "")
////                   labelImg.append(attachmentString)
////               chart2.centerAttributedText = labelImg
//    chart2.holeColor = UIColor.init(hexString: "#070806")
//
//}

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
    func convertnumbertopercentage(first : Double , second : Double , third : Double) -> [Double]{
                   var arr = [Double]()
                   var total = first + second + third
                   var a = ((first / total ) * 100)
                   arr.append(Double(a))
                   var b = (second / total ) * 100
                   arr.append(Double(b))
                   var c = (third / total ) * 100
                   arr.append(Double(c))
                  return arr
               }
    
func updateUII(){
    
    containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: self.frame.width, height: self.frame.height, enableInsets: true)
    
    
    
    chart2.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 300, height: 300, enableInsets: true)
    
    topLabel.anchor(top: containerView.topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 120, height: 15, enableInsets: true)
    
    onTargetValueLabel.anchor(top: chart2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
    onTargetValueLabel.layer.masksToBounds = true
    onTargetValueLabel.layer.cornerRadius = 25/2
    
    onTargetLabel.anchor(top: chart2.bottomAnchor, left: onTargetValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 5, paddingRight: 5, width: 90, height: 25, enableInsets: true)
    
    vulnerableValueLabel.anchor(top: chart2.bottomAnchor, left: onTargetLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
   
               vulnerableValueLabel.layer.masksToBounds = true
               vulnerableValueLabel.layer.cornerRadius = 25/2
               
    vulnerableLabel.anchor(top: chart2.bottomAnchor, left: vulnerableValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 5, paddingRight: 5, width: 90, height: 25, enableInsets: true)
    
     vulnerableLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor ).isActive = true
//            vulnerableValueLabel.layer.masksToBounds = true
//            vulnerableValueLabel.layer.cornerRadius = 25/2
//
    
//        offTatgetValueLabel.anchor(top: chart2.bottomAnchor, left: vulnerableLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
//
//        offTatgetValueLabel.layer.masksToBounds = true
//        offTatgetValueLabel.layer.cornerRadius = 25/2
//
//        offTatgetLabel.anchor(top: chart2.bottomAnchor, left: offTatgetValueLabel.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: -6, paddingBottom: 5, paddingRight: 5, width: 100, height: 25, enableInsets: true)
//
    
    offTatgetValueLabel.anchor(top: chart2.bottomAnchor, left: vulnerableLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25, enableInsets: true)
               offTatgetValueLabel.layer.masksToBounds = true
               offTatgetValueLabel.layer.cornerRadius = 25/2
               
    offTatgetLabel.anchor(top: chart2.bottomAnchor, left: offTatgetValueLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: -6, paddingBottom: 5, paddingRight: 5, width: 100, height: 25, enableInsets: true)
    

   }

}
//extension UIView {
//
//func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
//    var topInset = CGFloat(0)
//    var bottomInset = CGFloat(0)
//    
//    if #available(iOS 11, *), enableInsets {
//        let insets = self.safeAreaInsets
//        topInset = insets.top
//        bottomInset = insets.bottom
//        
//        print("Top: \(topInset)")
//        print("bottom: \(bottomInset)")
//    }
//    
//    translatesAutoresizingMaskIntoConstraints = false
//    
//    if let top = top {
//        self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
//    }
//    if let left = left {
//        self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
//    }
//    if let right = right {
//        rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
//    }
//    if let bottom = bottom {
//        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
//    }
//    
//    if height != 0 {
//        heightAnchor.constraint(equalToConstant: height).isActive = true
//    }
//    if width != 0 {
//        widthAnchor.constraint(equalToConstant: width).isActive = true
//    }
//    
//}
//
//}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}

