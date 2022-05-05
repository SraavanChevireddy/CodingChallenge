//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/5/22.
//

import UIKit

class ViewController: UITableViewController {

    private var ary_contacts: Array<ContactsListModel>!
    private var ary_searchContacts: Array<ContactsListModel>!
    private var isSearching = false
    
    private var searchController: UISearchController{
        let modalController = UISearchController(searchResultsController: nil)
        modalController.searchBar.placeholder = "Search Contacts"
        modalController.searchBar.delegate = self
        modalController.obscuresBackgroundDuringPresentation = false
        modalController.searchBar.barTintColor = .black
        modalController.edgesForExtendedLayout = .all
        return modalController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "cell")
        fetchAll()
    }

    
    private func fetchAll(){
        ary_contacts = Array()
        ary_searchContacts = Array()
        
        for _ in 0..<100{
            fetchContacts { result in
                switch result{
                case .success(let response):
                    print("You got")
                    DispatchQueue.main.async { [weak self] in
                        if let self = self{
                            self.ary_contacts.append(response)
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    private func fetchContacts(completion: @escaping(Result<ContactsListModel, NetworkError>)->Void){
        guard let urlForContacts = URL(string: "https://randomuser.me/api/") else{completion(.failure(.sourceNotFound)); return}
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: urlForContacts) { data, response, error in
            if let responseCode = response as? HTTPURLResponse{
                if responseCode.statusCode == 200{
                    if let decoder = try? JSONDecoder().decode(ContactsListModel.self, from: data!){
                        print("Done")
                        completion(.success(decoder))
                    }
                }else{
                    print("\(responseCode.statusCode)")
                }
            }
        }.resume()
    }
}

//MARK: TableView delegate methods
extension ViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactsTableViewCell
        cell.card = isSearching ? ary_searchContacts[indexPath.row] : ary_contacts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? ary_searchContacts.count  : ary_contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc_details = ContactDetailsViewController(ary_contacts[indexPath.row])
        self.navigationController?.pushViewController(vc_details, animated: true)
    }
}

// MARK: Search bar delegate methods
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        ary_searchContacts = ary_contacts.filter({ searchElement in
            if let firstName = searchElement.results.first?.name.first{
                if firstName.lowercased().contains(searchText){
                    return true
                }
            }
            return false
        })
        DispatchQueue.main.async { [weak self] in
            if let self = self{
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        DispatchQueue.main.async { [weak self] in
            if let self = self{
                self.tableView.reloadData()
            }
        }
    }
}
