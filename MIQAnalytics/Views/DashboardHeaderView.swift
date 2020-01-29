//
//  DashboardHeaderView.swift
//  MIQAnalytics
//
//  Created by Girish on 23/01/20.
//  Copyright © 2020 Girish. All rights reserved.
//

//
//  DashboardHeaderView.swift
//  googlMapTutuorial2
//
//  Created by Girish on 22/01/20.
//  Copyright © 2020 akhil. All rights reserved.
//

import UIKit

import Foundation
import UIKit

protocol StoreDelegate {
    func didPressButton(button:UIButton)
}

class DashboardHeaderView: UIView {
    var delegate:StoreDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        setupViews()
    }
    
//    func setData(title: String, img: UIImage, price: String) {
//        lblTitle.text = title + ",  " + price
//        imgView.image = img
//        lblPrice.text = price
//    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.size.width, height: 300, enableInsets:true)
        
//        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
//        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
//        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
//        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
       containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(loacatePlantbutton)
        loacatePlantbutton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)
        
        
        containerView.addSubview(locatePlantLabel)
        locatePlantLabel.anchor(top: containerView.topAnchor, left: loacatePlantbutton.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 100, height: 30, enableInsets: true)
        
        loacatePlantbutton.addTarget(self, action: #selector(buttonPress(button:)), for: .touchUpInside)
//        loacatePlantbutton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive=true
//        loacatePlantbutton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive=true
//        loacatePlantbutton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 30).isActive=true
//        loacatePlantbutton.widthAnchor.constraint(equalToConstant: 70).isActive=true
//        loacatePlantbutton.backgroundColor = UIColor.gray
//
       
    }
    
    @objc func btnMyLocationAction()  {
        print("Location button is pressed")
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.backgroundColor = UIColor.red
        v.translatesAutoresizingMaskIntoConstraints=false
        //v.alpha = 0.5
        
        v.layer.borderWidth  = 2.0
        //  v.layer.borderColor = (UIColor.red as! CGColor)
        v.layer.cornerRadius = 0.25
        
        
        return v
    }()
    
   
    
    let loacatePlantbutton: UIButton = {
        let btn = UIButton()
        //btn.titleLabel?.text = "locate Plant"
        btn.backgroundColor = UIColor.white
       btn.setTitleColor(.black, for: .normal)
       // btn.setTitle(" locate Plant ", for: .normal)
        btn.setImage(UIImage(named: "download"), for: .normal)
      
     
        return btn
    }()
    
    public let locatePlantLabel : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .black
           lbl.font = UIFont.boldSystemFont(ofSize: 12)
           lbl.textAlignment = .left
           lbl.backgroundColor = UIColor.clear
        lbl.text = "Locate Plant"
           return lbl
       }()
    
    let dashboardButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.text = "locate Plant"
        
        return btn
    }()
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func buttonPress(button:UIButton) {
        delegate.didPressButton(button: button)
    }
}





