//
//  String+Extensions.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 09/11/21.
//

extension String {

    func removingSpaces() -> String {

        return self.replacingOccurrences(of: " ", with: "")
    }
}
