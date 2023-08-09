//
//  SearchCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum Constant {
        static let title: String = "검색화면"
        static let dissmissButtonImage: String = "xmark"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissButton()
        title = Constant.title
    }
    
    func setDismissButton() {
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: Constant.dissmissButtonImage), style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
