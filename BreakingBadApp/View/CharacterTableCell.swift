//
//  CharacterTableCell.swift
//  BreakingBadApp
//
//  Created by Stefan Minchevski on 10/15/20.
//

import UIKit
import Kingfisher


class CharacterTableCell: UITableViewCell {
   
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblApperiance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.layer.cornerRadius = 20 //15
        myImageView.layer.borderWidth = 3
        myImageView.layer.borderColor = UIColor.gray.cgColor
        myImageView.image  = UIImage(named: "profile_placeholder")
        
    }
    
    func populate(character: Character) {
        lblName.text = character.name
        lblBirthday.text = character.birthday
        lblNickname.text = character.nickname
        if let urlstring = character.img {
            myImageView.kf.setImage(with: URL(string: urlstring))
            myImageView.contentMode = .scaleToFill
        }
             
        
        if let apperiance = character.appearance {
            var string = ""
            for app in apperiance {
                string = string + "\(app),"
            }
            string.removeLast()
            lblApperiance.text = "Appears in season: \(string)"
            
        }
    }

}
   
