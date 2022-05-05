//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 5/5/22.
//

import UIKit

class ViewController: UITableViewController {

    private var ary_contacts: Array<ContactsListModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "cell")
        fetchAll()
    }

    
    private func fetchAll(){
        ary_contacts = Array()
    
//        for _ in 0..<15{
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
//        }
    }
    
    private func fetchContacts(completion: @escaping(Result<ContactsListModel, NetworkError>)->Void){
        guard let urlForContacts = URL(string: "https://randomuser.me/api/") else{completion(.failure(.sourceNotFound)); return}
        URLSession.shared.dataTask(with: urlForContacts) { data, response, error in
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
        cell.card = ary_contacts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            let vc_details = ContactDetailsViewController(ary_contacts[indexPath.row])
            self.navigationController?.pushViewController(vc_details, animated: true)
        }catch{
            print("Content")
        }
    }
}

