//
//  DetailCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Sentence {
        static let memoTextViewPlaceHolder = "메모를 입력해주십시오"
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dissmissButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    
    var book: Book = Book(title: "", authors: [], imageUrl: "", content: "", price: 0, isLike: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        checkShowDismissButton()
        setMemoTextView()
    }
    
    func setMemoTextView() {
        memoTextView.delegate = self
        memoTextView.textColor = .gray
        memoTextView.text = Sentence.memoTextViewPlaceHolder
    }
    
    func checkShowDismissButton() {
        guard let navigationController else { return }
        dissmissButton.isHidden = true
    }
    
    func configureView() {
        title = book.title
        titleLabel.text = book.title
        authorsLabel.text = book.authors.joined(separator: ",")
        priceLabel.text = String(book.price)
        contentLabel.text = book.content
        posterImageView.getImageFromUrl(url: book.imageUrl)
    }
    
    @IBAction func tapDismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Sentence.memoTextViewPlaceHolder && textView.textColor == .gray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = Sentence.memoTextViewPlaceHolder
            textView.textColor = .gray
        }
    }
}
