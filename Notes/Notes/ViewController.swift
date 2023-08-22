//
//  ViewController.swift
//  Notes
//
//  Created by Derya Çayıroğlu on 21.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        add.tintColor = .systemOrange
        toolbarItems = [spacer, add]
        navigationController?.isToolbarHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notes = DataManager.load()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.detailTextLabel?.text = notes[indexPath.row].body
        cell.textLabel?.text = notes[indexPath.row].title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
    
    @objc func addNote() {
        openDetailView(info: "NewNote", noteIndex: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailView(info: "update", noteIndex: indexPath.row)
    }
    
    func openDetailView(info: String, noteIndex: Int) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.noteIndex = noteIndex
            vc.notes = self.notes
            vc.info = info
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

