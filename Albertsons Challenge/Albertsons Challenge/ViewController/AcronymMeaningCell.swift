//
//  AcronymMeaningCell.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import UIKit

class AcronymMeaningCell: UITableViewCell {
    @IBOutlet private weak var acronymMeaning: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with meaning: String) {
        acronymMeaning.text = meaning
    }
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
