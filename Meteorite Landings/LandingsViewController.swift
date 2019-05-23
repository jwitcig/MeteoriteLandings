//
//  ViewController.swift
//  Meteorite Landings
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import UIKit

class LandingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var meteorLandings: [MeteoriteLanding] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // find the JSON file
        guard let url = Bundle.main.url(forResource: "meteorite-landings", withExtension: "json") else {
            print("JSON file not found!")
            return
        }
        
        // grab the contents of the JSON file
        guard let data = try? Data(contentsOf: url) else {
            print("Could not retrieve contents of file!")
            return
        }
        
        // the decoder we will use to read out our data
        let decoder = JSONDecoder()
        
        // a custom date formatter for the decoder to use
        // since our JSON file's dates are in a tricky format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // decode the JSON file, given it is an array for MeteoriteLanding objects
        guard let landings = try? decoder.decode([MeteoriteLanding].self, from: data) else {
            print("Serialization failed!")
            return
        }
        
        // store the data on the view controller and reload the table view
        self.meteorLandings = landings
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteorLandings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeteoriteLandingCell", for: indexPath)
        
        let landing = meteorLandings[indexPath.row]
        cell.textLabel?.text = landing.name
        
        if let mass = landing.mass {
            cell.detailTextLabel?.text = "\(mass) kg"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LandingDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            print("No landings selected...did something go wrong?")
            return
        }
        
        let landing = meteorLandings[selectedPath.row]
        
        // if this is a segue to a LandingViewController, assign the landing property
        if let landingViewController = segue.destination as? LandingViewController {
            landingViewController.landing = landing
        }
    }
}

