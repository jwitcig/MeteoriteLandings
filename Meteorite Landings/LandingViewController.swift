//
//  LandingViewController.swift
//  Meteorite Landings
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import UIKit

/*
    Displays the details for a single meteorite landing.
*/
class LandingViewController: UIViewController {
    
    // outlets to our UI elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var observationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // the landing being viewed
    var landing: MeteoriteLanding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let landing = self.landing else {
            print("LandingViewController requires that 'landing' property is set before loading!")
            return
        }
        
        // setting values on the UI labels
        self.nameLabel.text = landing.name
        self.massLabel.text = "Mass: \(landing.mass != nil ? "\(landing.mass!) kg" : "unknown mass")"
        self.classLabel.text = "Class: \(landing.classification)"
        self.observationLabel.text = "Observed: \(landing.observed)"
        
        // setting more values on the UI labels,
        // this time checking that the values are present first (optional properties)
        if let date = landing.date {
            
            // making the date look pretty
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            self.dateLabel.text = "Date: \(formatter.string(from: date))"
        } else {
            self.dateLabel.text = "Date: ---"
        }
        
        if let latitude = landing.latitude, let longitude = landing.longitude {
            self.locationLabel.text = "Found at: \(latitude), \(longitude)"
        } else {
            self.locationLabel.text = "Found at: ---"
        }
    }
    
    @IBAction func backPressed(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
