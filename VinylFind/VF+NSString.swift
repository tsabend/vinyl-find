//
//  VF+NSString.swift
//  VinylFind
//
//  Created by Thomas Abend on 3/10/15.
//  Copyright (c) 2015 Thomas Abend. All rights reserved.
//

import Foundation


extension String {
    func camelToSnake()->String{
        var arr = map(self) { String($0) }
        var str = ""
        for letter in arr {
            if letter == letter.capitalizedString {
                str += "_\(letter.lowercaseString)"
            } else
            {
                str += letter
            }
        }
        return str
    }
    
    func snakeToCamel()->String{
        var splitString = self.componentsSeparatedByString("_")
        var firstString = splitString.removeAtIndex(0)
        var capitalizedString = splitString.map({string in string.uppercaseString})
        capitalizedString.insert(firstString, atIndex: 0)
        return "".join(capitalizedString)
    }
}

    
