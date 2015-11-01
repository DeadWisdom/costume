//
//  CardModel.swft.swift
//  Costume
//
//  Created by Brantley Harris on 10/31/15.
//  Copyright © 2015 Brantley Harris, Inc. All rights reserved.
//

import UIKit

class Card {
    let text: String
    let order: Int
    
    init(text: String, order: Int) {
        self.text = text
        self.order = order
    }
}