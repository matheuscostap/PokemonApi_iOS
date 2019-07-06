//
//  TypeCollectionViewCell.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblType: UILabel!
    
    
    var type: TypeModel!{
        didSet{
            self.lblType.text = type.name.uppercased()
            self.backgroundColor = type.getColor()
        }
    }
}
