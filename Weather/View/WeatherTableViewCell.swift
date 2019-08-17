//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/15/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    // label to show day
    var dayLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //label to show highest temp for the day
    var highLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //label to show lowest temp for the day
    var lowLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(lowLabel)
        self.addSubview(dayLabel)
        self.addSubview(highLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
            dayLabel.leftAnchor.constraint(equalTo:  self.leftAnchor, constant: 1).isActive = true
            dayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    
            lowLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
            lowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


            highLabel.leftAnchor.constraint(equalTo: lowLabel.leftAnchor, constant: -80).isActive = true
            highLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
    }
    
}


