//
//  SearchedBook.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/09/06.
//

import Foundation
import RealmSwift

final class SearchedBook: Object {
    @Persisted(primaryKey: true) var title: String
    @Persisted var imageUrl: String
    @Persisted var content: String
    @Persisted var price: Int
    @Persisted var isLike: Bool
    
    convenience init(title: String, imageUrl: String, content: String, price: Int, isLike: Bool) {
        self.init()
        self.title = title
        self.imageUrl = imageUrl
        self.content = content
        self.price = price
        self.isLike = isLike
    }
    
    func toDomain() -> Book {
        return Book(title: title, authors: [], imageUrl: imageUrl, content: content, price: price, isLike: isLike)
    }
}
