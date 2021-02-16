//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by Stefan Minchevski on 10/12/20.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var allCharacters: [Character] = []
    var filteredCharacters: [Character] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getCharacters()
        setupTableView()
        
        
        title = "Breaking Bad Cast"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        tableView.tableFooterView = nil
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableCell.self, forCellReuseIdentifier: "tableCell")
        tableView.register(UINib(nibName: "CharacterTableCell",
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: "tableCell")
    }
    
    private func getCharacters() {
        APIManager.shared.getCharacters { (characters, error) in
            if let error = error {
                self.showAlertDialog(error: error)
            } else {
                self.allCharacters = characters
                self.filteredCharacters = characters
                self.tableView.reloadData()
                UIView.animate(withDuration: 0.5) {
                    self.loadingView.alpha = 0
                } completion: { _ in
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func showAlertDialog(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { (_) in
            self.getCharacters()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchCharacters(string: String) {
        if string.isEmpty {
            filteredCharacters = allCharacters
        } else {
            filteredCharacters = allCharacters.filter { (character) -> Bool in
                guard let name = character.name?.lowercased(),
                      let nickname = character.nickname?.lowercased()
                else { return false }
                return name.contains(string.lowercased()) || nickname.contains(string.lowercased())
            }
        }
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CharacterTableCell
        let character = filteredCharacters[indexPath.row]
        cell.populate(character: character)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let char = filteredCharacters[indexPath.row]
        performSegue(withIdentifier: "ToDetailVC", sender: nil)
        
    }
}

extension ViewController: UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let searchBar = UISearchBar()
            searchBar.sizeToFit()
            searchBar.placeholder = ""
//            self.navigationController?.navigationBar.topItem?.titleView = searchBar
        
        if searchText == "" {
            filteredCharacters.removeAll()
            filteredCharacters.append(contentsOf: allCharacters)
            tableView.reloadData()
            return
        }
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        filteredCharacters = allCharacters.filter({ $0.name!.lowercased().hasPrefix(text.lowercased()) || $0.nickname!.lowercased().hasPrefix(text.lowercased())})
        tableView.reloadData()
    }
}
