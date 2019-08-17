//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/15/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    var dayLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var highLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
//                lowLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 50).isActive = true
                //lowLabel.w
                lowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


        highLabel.leftAnchor.constraint(equalTo: lowLabel.leftAnchor, constant: -80).isActive = true
        highLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                //highLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
}


