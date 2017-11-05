//
//  Note.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/3/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import Foundation

//Todo: Define the note class
//Needs: properties for title, contents; class initializer

class Note {
    let title: String
    let contents: String
    
    init(title: String, contents: String){
        self.title = title
        self.contents = contents
    }
}
