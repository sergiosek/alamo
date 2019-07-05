//
//  ViewController.swift
//  PokemonApp
//
//  Created by Luis Rollon Gordo on 12/6/17.
//  Copyright © 2017 EfectoApple. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var imageURLArray: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        downloadDataFromAPI()
    }
    
    func downloadDataFromAPI(){
        Alamofire.request("http://private-5d2b9-efectoapplepokemonapp.apiary-mock.com/pokemonList") .responseJSON { response in
            
            if let JSON = response.result.value{
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary]{
                    
                    let name = item["name"] as? String
                    let imageURL = item["image"] as? String
                    self.nameArray.append((name)!)
                    self.imageURLArray.append((imageURL)!)
                }
                
                self.tableView.reloadData()
                
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonCell
        
        cell.pokemonName.text = self.nameArray[indexPath.row]
        
        let url = URL(string: self.imageURLArray[indexPath.row])
        cell.pokemonImage.af_setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        return height/3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}



