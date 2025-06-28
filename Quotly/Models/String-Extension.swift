//
//  String-Extension.swift
//  Quotly
//
//  Created by Saverio Negro on 19/02/25.
//

extension String {
    func getChar(at index: Int) -> String {
        
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        let character = self[stringIndex]
        
        return String(character)
    }
}
