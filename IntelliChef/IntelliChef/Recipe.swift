//
//  Recipe.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import Foundation

class Recipe {
    var name : String
    var id : String
    var category : String
    var summary : String
    var prepTime : String
    var cookTime : String
    var steps : Int
    
    init(id: String, name: String, prep: String, cook: String) {
        self.name = name
        self.id = id
        self.category = "DEAD"
        self.summary = "Bacon ipsum dolor amet tongue jerky ham hock shoulder, frankfurter pastrami drumstick ground round. Pork chop landjaeger cow meatball, capicola spare ribs jerky andouille sausage turkey drumstick frankfurter turducken burgdoggen tail."
        self.prepTime = prep
        self.cookTime = cook
        self.steps = 10
    }}
