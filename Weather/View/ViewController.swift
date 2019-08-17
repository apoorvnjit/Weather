//
//  ViewController.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/13/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import UIKit
import CoreLocation

//protocol WeatherDelegate: AnyObject{
//    func changeCity(city: String )
//    func changeLatLong(Lat: Double, Long: Double)
//}


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    
    
    //constants
    let locationManager = CLLocationManager()
    let _padding: CGFloat = 5
    let _cellId = "cellId"
    let _width = 50
    let _height = 80
    let _top: CGFloat = 2
    let _left: CGFloat = 2
    let _bottom: CGFloat = 2
    let _right: CGFloat = 2
    let _tempDegreeC = "°C"
    let _tempDegreeF = "°F"
    
    
    // variables
    
    weak var delegate: locationUpdateDelegate!
    
    // initializing view model for current weather
    private(set) var weatherViewModel: WeaterViewModel?
    var result: CurrentWeatherModel?{
        didSet{
            guard let result = result else {return}
            weatherViewModel = WeaterViewModel.init(currentWeather: result)
        }
    }
    
    // inititlizing view model for forecast data
    private(set) var forecast: DailyForecastViewModel?
    var resultData: ForecastModel?{
        didSet{
            guard let resultData = resultData else {return}
            forecast = DailyForecastViewModel.init(forecastData: resultData)
        }
    }
    
    //private var locationUpdatedelegate: locationViewModel!
    
    

    var currentLocation: CLLocation!
    var day = 0 // initiializing day for today's data
    var tempDegree = "°F" // to check and change data to Farhenhier oe celcius
    
    
    // initializing UI elements
    
    // Location name text where user can input city name
    let cityText: UITextField = {
        let textFiled = UITextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.backgroundColor = .clear
        textFiled.layer.cornerRadius = 8.0
        textFiled.layer.borderColor = UIColor.gray.cgColor
        textFiled.layer.borderWidth =  1.0
        textFiled.textColor = .white
        textFiled.attributedPlaceholder = NSAttributedString(string:"Enter City eg. Garwood, US", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textFiled
    }()
    
    // Search button for location
    let addButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setTitle("Search", for: .normal)
        
        
        button.tintColor = .white
        button.showsTouchWhenHighlighted =  true
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth =  1.0
        button.setTitleColor(.gray, for: .normal)
        
        
        return button
    }()
    
    //  button for getting current location update
    let updateLocationdButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.setBackgroundImage(UIImage(named: "current"), for: .normal)
        
        
        button.tintColor = .white
        button.showsTouchWhenHighlighted =  true
        button.backgroundColor = .clear
        
        
        return button
    }()
    
    
    // label for current temperature
    let templabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    // switch button to change temp to Centigrate/ Farhenhite
    let tempSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        switchUI.onTintColor = .white
        switchUI.layer.borderWidth = 1
        switchUI.layer.cornerRadius = 8.0
        switchUI.layer.borderColor = UIColor.black.cgColor
        switchUI.setOn(true, animated: true)
        return switchUI
    }()
    
    // label to show day fopr the populated weather data
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        //label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    //background image
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Morning")
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //weather data for particualr day showed in collectionview
    let weatherCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        collection.layer.borderWidth = 1
        collection.layer.borderColor = UIColor.white.cgColor
        collection.backgroundColor = UIColor.clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    // name of the city  for which data being poipulated
    let locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // current temperature
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // current weather condition
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // show the image of weahter type
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "sun")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        imageView.layer.shadowOpacity = 3
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // table to show high low of next 5 days
    let forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        //tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    
    
    override func viewDidLoad() {
     super.viewDidLoad()
        
        
        //adding ui elements to screen
        setScreen()
        
        //initialise delegates for location update
        weatherViewModel?.setDelegates()
        
        //to check permission for user location
        _ = locationAuthCheck()
        
        //setting up some delegeates
        callDelegates()
        
        // setting up location related features
        setUpLocation()
        
        // gettin location and displaying the data
        _ = getCurrentData()
        
        
        setupScreenConstraints()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // to get loation data
        _ = locationAuthCheck()
    }
    
    func callDelegates() {
        locationManager.delegate = self
        cityText.delegate = self
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherCollectionViewCell.self
            , forCellWithReuseIdentifier: _cellId)
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: _cellId)
    }
    
    func disableButtonForEmptyCity(){
        addButton.isEnabled = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (cityText.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            addButton.isEnabled = false
            addButton.alpha = 0.5
        } else {
            addButton.isEnabled = true
            addButton.alpha = 1.0
        }
        return true
    }
    
    func getCurrentData() -> Bool{

        if(locationAuthCheck() && (currentLocation != nil)){

            Location.shared.latitude = currentLocation.coordinate.latitude
            Location.shared.longitude = currentLocation.coordinate.longitude
            fetchData()
            updateLabels()
            return true
        }else{
             Utility.shared.alert(message: "Cannot find current location, please check location service is enabled", view: self)
            return false
           
        }
        
        
    }
    func setUpLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationAuthCheck() -> Bool{
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            return true
        }else{
            locationManager.requestWhenInUseAuthorization()
            return false
        }
    }
    
    
    
    
    
    // function to update UI
    private func updateLabels() {
        
        templabel.text = tempDegree
        weatherLabel.text = weatherViewModel?.weatherType
        locationLabel.text = weatherViewModel?.cityName
        if(tempDegree == _tempDegreeC){
            temperatureLabel.text = weatherViewModel?.tempC
        }else{
            temperatureLabel.text = weatherViewModel?.tempF
        }
        
        weatherImageView.image = UIImage(named: weatherViewModel?.weatherType ?? "Clear")
        backgroundImageView.image = UIImage(named: weatherViewModel?.dayNight ?? "Morning")
        dateLabel.text = "Today"
        
        // update tables
        self.weatherCollectionView.reloadData()
        self.forecastTableView.reloadData()
    }
    
    
    
    
    //to fetch data from the api
    private func fetchData(){

            Service.shared.fetchData{ (data, err) in
                if let err = err {
                    DispatchQueue.main.async{
                        Utility.shared.alert(message: "Cannot download data network issue or location not found", view: self)
                    }
                    
                }
                guard let weather = data else { Utility.shared.alert(message: "Cannot download data network issue or location not found", view: self)
                    return}
                self.result = weather
                print(weather)
            
                
                
            }
        
        Service.shared.fetchForecastData{ (data, err)in
            if let err = err {
                DispatchQueue.main.async{
                    Utility.shared.alert(message: "Cannot download data network issue or location not found", view: self)
                }
                
            }
            guard let forData = data else { Utility.shared.alert(message: "Cannot download data network issue or location not found", view: self)
                return}
            self.resultData = forData
            
            self.updateLabels()
        }

    }
    
    
    
    
    /*
     Author: Apoorva Reed
     created: 08/14/2019
     func name:
     functionality: set constraints and animation
     */
    private func setupScreenConstraints(){
        let screenWidthSize = view.frame.width
        let screenHeightSize = view.frame.height
        let labelWidth = screenWidthSize/4
        let weatherLabelheight = screenHeightSize/30
        
        
        weatherCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        weatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        cityText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: _padding*8).isActive = true
        cityText.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        cityText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        

        addButton.leftAnchor.constraint(equalTo: cityText.rightAnchor, constant: _padding).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -_padding).isActive = true
        addButton.topAnchor.constraint(equalTo: cityText.topAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        addButton.bottomAnchor.constraint(equalTo: cityText.bottomAnchor).isActive = true
        
        
        
        updateLocationdButton.leftAnchor.constraint(equalTo: cityText.rightAnchor, constant: _padding).isActive = true
        updateLocationdButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: _padding).isActive = true
        updateLocationdButton.widthAnchor.constraint(equalToConstant: labelWidth/2).isActive = true
        updateLocationdButton.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        
        
        
        locationLabel.topAnchor.constraint(equalTo: cityText.bottomAnchor, constant: 3).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: labelWidth*2).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: weatherLabelheight*2).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        weatherImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: _padding).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: labelWidth).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: _padding).isActive = true
        weatherLabel.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: weatherLabelheight).isActive = true
        weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        tempSwitch.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -60 ).isActive = true
        tempSwitch.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -_padding*2).isActive = true
        
        

        templabel.topAnchor.constraint(equalTo: tempSwitch.bottomAnchor).isActive = true
        templabel.leftAnchor.constraint(equalTo: tempSwitch.leftAnchor).isActive = true
        
        
        forecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        forecastTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        forecastTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        forecastTableView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: _padding).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: weatherCollectionView.topAnchor, constant: -_padding*2).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: labelWidth*2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: weatherLabelheight).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        temperatureLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -_padding).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: labelWidth/2).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        // animation for the weather
        animateView(view: weatherImageView, intensity: 40)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        disableButtonForEmptyCity()
        self.view.addGestureRecognizer(tap)
        
        view.addGestureRecognizer(tap)
    }
    
    
    
    private func setupBacground(){
        
        
    }
    private func animateView(view: UIView, intensity: Double){
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -intensity
        horizontalMotion.maximumRelativeValue = intensity
        
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -intensity
        verticalMotion.maximumRelativeValue = intensity
        
        let animation = UIMotionEffectGroup()
        animation.motionEffects = [horizontalMotion,verticalMotion]
        view.addMotionEffect(animation)
    }
    
}

/*
 Author: Apoorva Reed
 created: 08/14/2019
 func name:
 functionality: setting up data for collection view
 */

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast?.dailyWeather[day].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: _cellId, for: indexPath) as! WeatherCollectionViewCell
        cell.backgroundColor = .clear
        
        let currentdata:todaysData? = forecast?.dailyWeather[day][indexPath.row]
    
        if(tempDegree == _tempDegreeC){
            cell.temperatureLabel.text = currentdata?.tempC
        }else{
            cell.temperatureLabel.text = currentdata?.tempF
        }
        
          cell.timeLabel.text = currentdata?.time
        cell.weatherImageView.image = UIImage(named: currentdata?.weather ?? "Rain")

        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: _width, height: _height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: _top, left: _left, bottom: _bottom, right: _right)
    }
    
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.dailyWeather.count ?? 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.day = indexPath.row
        self.weatherCollectionView.reloadData()
        let currentdata = forecast?.dailyWeather[indexPath.row][0]
        
        self.dateLabel.text = ("\(currentdata!.day) \(currentdata!.date)")
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellId, for: indexPath) as! WeatherTableViewCell
        let currentdataCount = forecast?.dailyWeather[indexPath.row].count ?? 1
        let currentdata = forecast?.dailyWeather[indexPath.row][currentdataCount-1]
        cell.dayLabel.text = currentdata?.day
        if(tempDegree == _tempDegreeC){
            cell.lowLabel.text = currentdata?.lowTempC
            cell.highLabel.text = currentdata?.highTempC
        }else{
            cell.lowLabel.text = currentdata?.lowTempF
            cell.highLabel.text = currentdata?.lowTempF
        }
        

        
        return cell
    }
    
    
    
    
}

extension ViewController{
    
    func setScreen(){
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        view.addSubview(weatherCollectionView)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherLabel)
        view.addSubview(weatherImageView)
        view.addSubview(locationLabel)
        view.addSubview(forecastTableView)
        view.addSubview(dateLabel)
        view.addSubview(tempSwitch)
        view.addSubview(templabel)
        view.addSubview(addButton)
        view.addSubview(cityText)
        view.addSubview(updateLocationdButton)
        
        updateLocationdButton.addTarget(self, action: #selector(searchCurrentWeather), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(searchCity), for: .touchUpInside)
        tempSwitch.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
    }
}

extension ViewController{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func searchCurrentWeather(sender: UIButton){
        
        if(getCurrentData()){
            Location.shared.city = nil
            fetchData()
            updateLabels()
        }
    }
    
    @objc func searchCity(sender: UIButton){
        
        
        let text = cityText.text ?? ""
        Location.shared.city = text
        weatherViewModel?.updateCityName(city: text)
        fetchData()
        updateLabels()
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            
            tempDegree = _tempDegreeF
            updateLabels()
            
        }
        else{
            
            tempDegree = _tempDegreeC
            updateLabels()
            
        }
    }
    
}
    
    

