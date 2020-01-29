//
//  InfoPreviewView.swift
//  MIQAnalytics
//
//  Created by Girish on 03/12/19.
//  Copyright © 2019 Girish. All rights reserved.
//

import UIKit

class InfoPreviewView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        setupViews()
    }
    
    func setData(title: String, img: UIImage, price: String) {
        lblTitle.text = title + ",  " + price
        imgView.image = img
        lblComments.text = price
        
        
    }
    
    func setDatanew( displayname: String, healthPrec : Int , hirarchy : Int )   {
        lblTitle.text = displayname
        lblComments.text = displayname
        progressView.progress = Float(healthPrec) / 100
        percentageLabel.text = String(healthPrec) + "%" + "  " + "Healthy"
    }
    func setDataInfoview( displayname: String, comments: String, healthPrec : Int , hirarchy : Int )   {
           lblTitle.text = displayname
           lblComments.text = comments
           progressView.progress = Float(healthPrec) / 100
           percentageLabel.text = String(healthPrec) + "%" + "  " + "Healthy"
       }
    
    func setupViews() {
        
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        containerView.backgroundColor = UIColor.black
        
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive=true
        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 40).isActive=true
        
        
        
        containerView.addSubview(lblComments)
        lblComments.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive=true
        lblComments.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 0).isActive=true
        lblComments.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10).isActive=true
        lblComments.heightAnchor.constraint(equalToConstant: 20).isActive=true
        
        
        containerView.addSubview(progressView)
        
        progressView.topAnchor.constraint(equalTo: lblComments.bottomAnchor, constant: 10).isActive=true
        progressView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive=true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive=true
        progressView.widthAnchor.constraint(equalToConstant: 350).isActive=true
        
        containerView.addSubview(percentageLabel)
        percentageLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive=true
        percentageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive=true
        //percentageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive=true
        percentageLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 50).isActive=true
        percentageLabel.heightAnchor.constraint(equalToConstant: 25).isActive=true
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = UIColor.gray
        v.translatesAutoresizingMaskIntoConstraints=false
        
        v.layer.borderWidth  = 2.0
        //  v.layer.borderColor = (UIColor.red as! CGColor)
        v.layer.cornerRadius = 0.25
        
        
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image=#imageLiteral(resourceName: "restaurant1")
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "     Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor(hexString: "#1e91ca")
        lbl.backgroundColor = UIColor.clear
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblComments: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor.clear
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    let percentageLabel: UILabel = {
        let lbl=UILabel()
        //lbl.text = "54% healthy"
        lbl.font=UIFont.boldSystemFont(ofSize:20)
        lbl.textColor = UIColor.green
        lbl.backgroundColor = UIColor.clear
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let progressView : UIProgressView = {
        
        let progess = UIView()
        progess.backgroundColor = UIColor.red
        let progressview = UIProgressView(progressViewStyle: .bar)
        progressview.center = progess.center
        progressview.setProgress(0.5, animated: true)
        progressview.trackTintColor = UIColor.white
        progressview.tintColor = UIColor.green
        progressview.backgroundColor = UIColor.green
       // progressview.progress = 0.5
        progressview.clipsToBounds = true
        progressview.layer.cornerRadius = 5
        progressview.translatesAutoresizingMaskIntoConstraints=false
        return progressview
        
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}
