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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dissmissButton: UIButton!
    @IBOutlet weak var memoTextView: UITextView!
    
    var movie: Movie = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0.0)
    
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
        title = movie.title
        posterImageView.image = UIImage(named: movie.title)
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        runtimeLabel.text = String(movie.runtime)
        rateLabel.text = String(movie.rate)
        overviewLabel.text = movie.overview
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
