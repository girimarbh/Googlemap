
//
//  DetailsVC.swift
//  googlMapTutuorial2
//
//  googlMapTutuorial2
//
//  Created by Girish on 03/01/20.


import UIKit




class DetailsVC : UIViewController, UITableViewDelegate, UITableViewDataSource , DashbardNotificationProtocal , StoreDelegate {
    func didPressButton(button: UIButton) {
        print("didPressButton is called in detailvc")
        self.dismiss(animated: true, completion: nil)
    }
    
    var properties = [String]()
    var values = [Double]()
    var passdata : String?
 var dashboardviewmodel = DashboardViewModel()
    private let myArray: NSArray = ["First","Second","Third"]
   private var myTableView: UITableView!
    let cellId = "cellId"
     let cellId2 = "cellId2"
    let cellId3 = "cellId3"
var activityView: UIActivityIndicatorView?

    var headerView: DashboardHeaderView = {
        let v = DashboardHeaderView()
        v.translatesAutoresizingMaskIntoConstraints=false

        return v
    }()

//    var myTableView : UITableView = {
//        let v = UITableView()
//        return v
//    v.translatesAutoresizingMaskIntoConstraints=false
//    }()




    override func viewDidLoad() {

      super.viewDidLoad()

        if ReachabilityTest.isConnectedToNetwork() {


            dashboardviewmodel.fetchData(plantid: passdata!)
            self.showActivityIndicator()
             dashboardviewmodel.delegate = self as? DashbardNotificationProtocal

            //Calling Viewmodel class to fetchdata
        }
        else{
           let alert = UIAlertController(title: internetConnection, message: noInternetAvailable , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancel , style: .cancel, handler: {[weak self] _ in
                guard let weakSelf = self else { return }

            }))
            self.present(alert, animated: true, completion: nil)

        }


        let guide = view.safeAreaLayoutGuide

        properties = ["","",""]
               values = [1000.0,2000.0,3000.0]

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

       headerView  = DashboardHeaderView(frame: CGRect(x: 0.0, y: barHeight, width: self.view.frame.width, height: 50 ))
        headerView.delegate = self
      self.view.addSubview(headerView)
//       headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:0).isActive=true
//       headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive=true
//       headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive=true
//       headerView.heightAnchor.constraint(equalToConstant: 70).isActive=true

//        self.view.addSubview(myTableView)
//        myTableView.anchor(top: self.view.topAnchor , left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height:displayHeight, enableInsets: false)
//
        
        //      myTableView.topAnchor.constraint(equalTo: self.view.topAnchor ).isActive=true
//        myTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
//        myTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
//        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive=true


        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+60 , width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(PieChartCell.self, forCellReuseIdentifier: cellId)
        myTableView.register(PlantStatusCell.self, forCellReuseIdentifier: cellId2)
        myTableView.register(KPIStstusCell.self, forCellReuseIdentifier: cellId3)
     //   myTableView.dataSource = self
       // myTableView.delegate = self
        myTableView.showsVerticalScrollIndicator = false
       self.view.addSubview(myTableView)
        self.myTableView.isHidden = true











    }

    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50.0
//
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {



        if indexPath.row == 0 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PieChartCell
                           cell.properties = ["United States","Mexico","Canada","Chile"]
                           cell.values = [1000.0,2000.0,3000.0,4000.0]
                //   cell.updateCellContentt(property:properties , value: values
            cell.updateCellContentt(categoryhealth: dashboardviewmodel.health!)
                           return cell
               }

            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as! PlantStatusCell
                        cell.properties = ["United States","Mexico","Canada","Chile"]
                        cell.values = [1000.0,2000.0,3000.0,4000.0]
                cell.updateCellContentt(categoryhealth: dashboardviewmodel.health!)
                        return cell
            }
               else   {
                   let cell = tableView.dequeueReusableCell(withIdentifier: cellId3, for: indexPath) as! KPIStstusCell
                           cell.properties = ["United States","Mexico","Canada","Chile"]
                           cell.values = [1000.0,2000.0,3000.0,4000.0]
                cell.updateCellContentt(categoryhealth: dashboardviewmodel.arrcategoryhealth[indexPath.row - 2] )
                           return cell
               }

//                 let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PieChartCell
//                cell.properties = ["United States","Mexico","Canada","Chile"]
//                cell.values = [1000.0,2000.0,3000.0,4000.0]
//        cell.updateCellContentt(property:properties , value: values)
//                return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardviewmodel.arrcategoryhealth.count + 2


    }


     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1{
      return  400
    }
        else{

         return   270
        }

}

    func updateContentOnView(){
        DispatchQueue.main.async{ [weak self] in
            guard let weakSelf = self else { return }
            // and then dismiss the control
            self?.hideActivityIndicator()
            self?.myTableView.isHidden = false
            self?.myTableView.dataSource = self
            self?.myTableView.delegate = self
            self?.myTableView.reloadData()

        }
    }
}
