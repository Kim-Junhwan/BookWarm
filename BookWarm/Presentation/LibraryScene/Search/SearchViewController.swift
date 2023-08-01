//
//  SearchCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissButton()
        title = "검색화면"
    }
    
    func setDismissButton() {
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }

}
