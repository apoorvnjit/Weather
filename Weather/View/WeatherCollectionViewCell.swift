//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/13/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    //constants
    let _height: CGFloat = 40
    let _width: CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    //label for time of the weather
    var timeLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // to show image for the weather
    var weatherImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        imageView.layer.shadowOpacity = 3
        imageView.backgroundColor = .clear
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // to show temperature at that hour
    var temperatureLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpView() {
        addSubview(timeLabel)
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
        
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: _height).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: _height).isActive = true
        
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: weatherImageView.topAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: _width).isActive = true
        //
        temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: _width).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
