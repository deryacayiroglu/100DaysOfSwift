//
//  DetailViewController.swift
//  Notes
//
//  Created by Derya Çayıroğlu on 21.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var notes: [Note]!
    var noteTitle: String!
    var noteBody: String!
    var noteIndex: Int!
    var info: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemOrange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if info == "update" {
            textView.text = notes[noteIndex].body
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let text = textView.text, !text.isEmpty{
            let lineArr = text.split(separator: "\n")
            guard !lineArr.isEmpty else { return }
            noteTitle = String(lineArr[0])
            noteBody = lineArr.joined(separator: " ")
            let newNote = Note(title: noteTitle, body: noteBody)
            if info == "NewNote" {
                notes.insert(newNote, at: noteIndex)
            } else {
                notes[noteIndex] = newNote
            }
            DataManager.save(notes)
        }
    }
    
    @objc func doneTapped() {
        textView.endEditing(true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
}
