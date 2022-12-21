//
//  popUpViewController.swift
//  Tommy_Nguyen_ios_prework
//
//  Created by Toi thich an CHUOI on 12/21/22.
//

import UIKit

class popUpViewController: UIViewController {
    
    var firstName: String = ""
    var introduction: String = ""
    var favColor: String = ""
    var favActivity: String = ""
    var favMovie: String = ""
    var chosenTrait: String = ""
    var chosenTraitSize: CGFloat = 17.0
    
    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBOutlet weak var introductionTextView: UITextView!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityImageView: UIImageView!
    
    @IBOutlet weak var buttonPopUp: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introductionLabel.text = firstName + " Introduction"
        introductionTextView.text = introduction
        movieImageView.image = UIImage(named: favMovie)
        movieImageView.contentMode = .scaleToFill
        activityImageView.image = UIImage(named: favActivity)
        activityImageView.contentMode = .scaleToFill
        changeViewColor(colorType: favColor)
        changeFontFamilyStyle(fontStyle: chosenTrait, fontSize: chosenTraitSize)
    }
    
    func changeViewColor(colorType color: String){
        switch color {
        case "Red":
            coverView.backgroundColor = UIColor.red
        case "Blue":
            coverView.backgroundColor = UIColor.blue
        case "Green":
            coverView.backgroundColor = UIColor.green
        case "Yellow":
            coverView.backgroundColor = UIColor.yellow
        case "Pink":
            coverView.backgroundColor = UIColor.systemPink
        case "Purple":
            coverView.backgroundColor = UIColor.purple
        case "Black":
            coverView.backgroundColor = UIColor.black
        case "White":
            coverView.backgroundColor = UIColor.white
        case "Orange":
            coverView.backgroundColor = UIColor.orange
        default:
            break
        }
    }
    
    func changeFontFamilyStyle(fontStyle style:String, fontSize size: CGFloat) {
        introductionLabel?.font = UIFont(name: style, size: size)
        introductionTextView?.font = UIFont(name: style, size: size)
        buttonPopUp.titleLabel?.font = UIFont(name: style, size: size)
    }

    @IBAction func hidePopUp(_ sender: Any) {
        dismiss(animated: true)
    }
}
