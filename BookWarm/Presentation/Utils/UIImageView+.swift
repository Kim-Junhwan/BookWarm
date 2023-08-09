//
//  UIImageView+.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/08/09.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func getImageFromUrl(url: String) {
        AF.request(url, method: .get).validate().response { response in
            switch response.result {
            case .success(let value):
                guard let value else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: value)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
