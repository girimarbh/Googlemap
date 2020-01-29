//
//  MapViewController.swift
//  MIQAnalytics
//
//  Created by Girish on 03/12/19.
//  Copyright © 2019 Girish. All rights reserved.
//



import UIKit
import GoogleMaps
import GooglePlaces


let kMapStyle = "[" +
"  {" +
"    \"featureType\": \"poi.business\"," +
"    \"elementType\": \"all\"," +
"    \"stylers\": [" +
"      {" +
"        \"visibility\": \"off\"" +
"      }" +
"    ]" +
"  }," +
"  {" +
"    \"featureType\": \"transit\"," +
"    \"elementType\": \"labels.icon\"," +
"    \"stylers\": [" +
"      {" +
"        \"visibility\": \"off\"" +
"      }" +
"    ]" +
"  }" +
"]"

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

struct PreviewDemoData {
    var title: String
    var img: UIImage
    var price: String
}

class MapViewController : UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, UITextFieldDelegate , NotificationProtocal {
   let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 250
    let customMarkerHeight: Int = 100
    
    var previewDemoData = [PreviewDemoData]()
     var mapviewmodel = MapViewModel()
    var placearray = [Place]()
    
//    let previewDemoData = [(title: "washington", img: #imageLiteral(resourceName: "restaurant1"), price: "wa"), (title: "Newyork", img: #imageLiteral(resourceName: "restaurant2"), price: "Nw"), (title: "Dallas", img: #imageLiteral(resourceName: "restaurant3"), price: "Da")]
    
    override func viewDidLoad() {
        if ReachabilityTest.isConnectedToNetwork() {
            
            mapviewmodel.fetchData()
            
            //Calling Viewmodel class to fetchdata
        }
        else{
           let alert = UIAlertController(title: internetConnection, message: noInternetAvailable , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancel , style: .cancel, handler: {[weak self] _ in
                guard let weakSelf = self else { return }
               
            }))
            self.present(alert, animated: true, completion: nil)
           
        }
        mapviewmodel.fetchData()
        GMSServices.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        GMSPlacesClient.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        mapviewmodel.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

       super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        self.previewDemoData.append(PreviewDemoData(title: "washington", img: (UIImage(named: "PinImage") ?? nil)! , price: "wa") )
        self.previewDemoData.append(PreviewDemoData(title: "Newyork", img: (UIImage(named: "PinImage") ?? nil)! , price: "NW") )
        self.previewDemoData.append(PreviewDemoData(title: "Dallas", img: (UIImage(named: "PinImage") ?? nil)! , price: "da") )

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

        setupViews()
//
        initGoogleMaps()
//
        txtFieldSearch.delegate=self
        setupNavigation()
//
//
        
    }
    
    func setupMapview()  {
        
        mapviewmodel.delegate = self
        GMSServices.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        GMSPlacesClient.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        
        
       
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        self.previewDemoData.append(PreviewDemoData(title: "washington", img: (UIImage(named: "PinImage") ?? nil)! , price: "wa") )
        self.previewDemoData.append(PreviewDemoData(title: "Newyork", img: (UIImage(named: "PinImage") ?? nil)! , price: "NW") )
        self.previewDemoData.append(PreviewDemoData(title: "Dallas", img: (UIImage(named: "PinImage") ?? nil)! , price: "da") )
        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        //initGoogleMaps()
        
        txtFieldSearch.delegate=self
        setupNavigation()
    }
    
    func updateContentOnView(){
        DispatchQueue.main.async{ [weak self] in
            guard let weakSelf = self else { return }
            print("place array in Mapview new is \(self?.mapviewmodel.placearray)")
            self?.placearray = (self?.mapviewmodel.placearray)!
            self?.setupData(placearray: self?.placearray )
//            self?.setupMapview()
            self?.showPartyMarkersNew()
            

        }
    }
    
    func setupData(placearray : [Any]?)  {
        for placearr in placearray!
        {
            if let dict = placearr as? [String: Any]{
                let code = dict["CODE"] as! String
                let Comments = dict["COMMENTS"] as! String
                let displayname = dict["DISPLAYNAME"] as! String
                let healthPrec = (dict["HEALTHPERC"] as! NSString).intValue
                let hirarchy = (dict["HIRARCHY"] as! NSString) ?? "0" 
                let latitude = (dict["LATITUDE"] as! NSString).doubleValue
                let longitude = (dict["LONGITUDE"] as! NSString).doubleValue
                let map = (dict["MAP"] as! NSString).intValue
                let plantid = dict["PLANTID"] as! String
                self.placearray.append(Place(code: Int(code), comments: Comments, displayName: displayname, healthperc: Int(healthPrec), hirarchy: Int(hirarchy as String), latitude: latitude, longitude: longitude, map: Int(map), plantID: plantid))
                
            }
            
            
            
        }
        
    }
    func setupNavigation()  {
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        let lat = place.coordinate.latitude
//        let long = place.coordinate.longitude
        
//        let lat = 33.56451
//        let long = -84.57889
//        
//        
//        
//       // showPartyMarkers(lat: lat, long: long)
//        
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
//        myMapView.camera = camera
//        txtFieldSearch.text=place.formattedAddress
//        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
//        let marker=GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        marker.title = "\(place.name)"
//        marker.snippet = "\(place.formattedAddress!)"
//        marker.map = myMapView
//        
//        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 33.56451, longitude: -84.57889, zoom: 5.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
        //self.myMapView.mapType = .hybrid
        do {
          // Set the map style by passing a valid JSON string.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
            myMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            }
            
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
        //showPartyMarkersNew()
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
      //  self.myMapView.animate(to: camera)
        
      //  showPartyMarkers(lat: lat, long: long)
       
    }
    
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
//        let img = customMarkerView.img!
//        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
//
//        marker.iconView = customMarker
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        //let data = previewDemoData[customMarkerView.tag]
        let data = self.mapviewmodel.placearray[customMarkerView.tag]
       // infoPreviewView.setDatanew( displayname: data.displayName ?? "aa", healthPrec: data.healthperc ?? 11, hirarchy: data.hirarchy ?? 11)
        infoPreviewView.setDataInfoview(displayname: data.displayName ?? "aa", comments: data.comments ?? "aa", healthPrec: data.healthperc ?? 11, hirarchy: data.healthperc ?? 11)
        //infoPreviewView.setData(title: data.title, img: data.img, price: data.price)
        return infoPreviewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        
        restaurantTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
      //  let img = customMarkerView.img!
//        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag , title : customMarkerView.title)
//        marker.iconView = customMarker
    }
    
//    func showPartyMarkers(lat: Double, long: Double) {
//        myMapView.clear()
//        for i in 0..<3 {
//            let randNum=Double(arc4random_uniform(30))/10000
//            let marker=GMSMarker()
//            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i , title : previewDemoData[i].title )
//            marker.iconView=customMarker
//            let randInt = arc4random_uniform(4)
//            if randInt == 0 {
//                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
//            } else if randInt == 1 {
//                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
//            } else if randInt == 2 {
//                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
//            } else {
//                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
//            }
//            marker.map = self.myMapView
//        }
//    }
    
    func showPartyMarkersNew() {
        myMapView.clear()
        for i in 0..<self.mapviewmodel.placearray.count  {
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight),  borderColor: UIColor.darkGray, tag: i , title : mapviewmodel.placearray[i].displayName ?? "aa"  , code: mapviewmodel.placearray[i].code ?? 11 , healthperc: Float(mapviewmodel.placearray[i].healthperc ?? 11)  )
                       marker.iconView=customMarker
            marker.position = CLLocationCoordinate2D(latitude:mapviewmodel.placearray[i].latitude ?? 1 , longitude: mapviewmodel.placearray[i].longitude ?? 11)
             marker.map = self.myMapView
          
      }
        
    }
    
   
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @objc func restaurantTapped(tag: Int) {
        let v=DetailsVC()
        v.modalPresentationStyle = .fullScreen
        v.passdata = mapviewmodel.placearray[tag].comments
     print("passed value is \(mapviewmodel.placearray[tag].comments)")
      self.present(v , animated: true , completion: nil)
    }
    
    func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    
    func setupViews() {
        view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
        
        
        self.view.addSubview(txtFieldSearch)
        txtFieldSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive=true
        txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
        txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
        setupTextField(textField: txtFieldSearch, img: #imageLiteral(resourceName: "map_Pin"))
        
        infoPreviewView=InfoPreviewView(frame: CGRect(x: 10.0, y: 10.0, width: self.view.frame.width - 10, height: 150))
        
        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive=true
        btnMyLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
    }
    
    let myMapView: GMSMapView = {
        GMSServices.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        GMSPlacesClient.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        let v = GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let txtFieldSearch: UITextField = {
        let tf=UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="Search for a location"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "my_location"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    var infoPreviewView: InfoPreviewView = {
        let v=InfoPreviewView()
        return v
    }()
}




