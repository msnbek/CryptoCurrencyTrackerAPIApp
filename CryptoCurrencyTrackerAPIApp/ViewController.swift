//
//  ViewController.swift
//  CryptoCurrencyTrackerAPIApp
//
//  Created by Mahmut Senbek on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {

    var coins = [CoinStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
       

       
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        parseJson {
            self.tableView.reloadData()
            print("success")
            
        }
    }


}
//MARK: - TableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let coin = coins[indexPath.row]
        cell.textLabel?.text = coin.currency.capitalized
        cell.detailTextLabel?.text = "\(coin.price.capitalized) USD"
        return cell
    }
    
}

//MARK: - Gettin data from API
extension ViewController {
    
    func parseJson(completed: @escaping () -> () ) {
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                //alert
            }else {
                do {
                    self.coins = try JSONDecoder().decode([CoinStruct].self, from: data!)
                    DispatchQueue.main.async {
                        
                        completed()
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}

