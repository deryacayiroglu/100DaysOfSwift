//
//  ViewController.swift
//  ShoppingList
//
//  Created by Derya Çayıroğlu on 7.07.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(cleanList))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        toolbarItems = [spacer, add]
        navigationController?.isToolbarHidden = false
        
    }
    
    @objc func shareTapped(){
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    @objc func addList() {
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func cleanList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func submit(_ item: String){
        
        if isOriginal(word: item) {
            if isReal(word: item) {
                shoppingList.insert(item, at: 0)
                
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                
            } else {
                showErrorMessage(errorTitle: "Item not recognized", errorMessage: "You can't just make them up, you know!")
            }
        }else {
            showErrorMessage(errorTitle: "Item already be used", errorMessage: "Try again!")
        }
        
        
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 || title == word {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isOriginal(word: String) -> Bool {
        return !(shoppingList.description.lowercased().contains(word.lowercased()))
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

