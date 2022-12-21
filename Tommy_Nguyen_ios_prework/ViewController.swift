//
//  ViewController.swift
//  Tommy_Nguyen_ios_prework
//
//  Created by Toi thich an CHUOI on 12/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var morePetsSwitch: UISwitch!
    
    @IBOutlet weak var morePetsStepper: UIStepper!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    
    @IBOutlet weak var favColorPicker: UIPickerView!
    @IBOutlet weak var favActivityPicker: UIPickerView!
    @IBOutlet weak var favMoviesPicker: UIPickerView!
    
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var traitSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var academicYearLabel: UILabel!
    @IBOutlet weak var pickTraitLabel: UILabel!
    @IBOutlet weak var petsLabel: UILabel!
    @IBOutlet weak var morePetsLabel: UILabel!
    @IBOutlet weak var favColorLabel: UILabel!
    @IBOutlet weak var favActivityLabel: UILabel!
    @IBOutlet weak var favMovieLabel: UILabel!
    
    @IBOutlet weak var leftSideView: UIView!
    @IBOutlet weak var rightSideView: UIView!
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    
    // favColorPicker option
    let colors = ["White","Red", "Blue", "Green", "Yellow", "Pink", "Purple", "Black", "Orange"]
    // favSportPicker option
    let activities = ["None", "Sports", "Travel", "Eat", "Videogame", "Read", "Hike", "Fish"]
    // favMoviePicker option
    let movies = ["None", "The Dark Knight", "Avengers End Game", "The GodFather", "MadMax Fury Road", "Die Hard", "The Wolf of Wall Street", "Fight Club"]
    
    // Academic Year
    private var year = ""
    // chosen Trait, along with Trait's size
    private var chosenTrait = ""
    private var chosenTraitSize = 17.0
    // Favorite Color
    private var favColor = ""
    // Favorite Activity
    private var favActivity = ""
    // Favorite Movie
    private var favMovie = ""
    

    // Store data in UserDefault
    let userDefaults = UserDefaults()
    // Global data to Pass to another View
    var introduction = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favColorPicker.dataSource = self
        favColorPicker.delegate = self
        favActivityPicker.dataSource = self
        favActivityPicker.delegate = self
        favMoviesPicker.dataSource = self
        favMoviesPicker.delegate = self
        
        favColorPicker.tag = 0
        favActivityPicker.tag = 1
        favMoviesPicker.tag = 2
        
        // Fetch data from userDefaults
        if let firstName = userDefaults.object(forKey: "firstNameKey") as? String {
            firstNameTextField.text = firstName
        }
        
        if let lastName = userDefaults.object(forKey: "lastNameKey") as? String {
            lastNameTextField.text = lastName
        }
        
        if let schoolName = userDefaults.object(forKey: "schoolNameKey") as? String {
            schoolNameTextField.text = schoolName
        }
        
        if let numOfPets = userDefaults.object(forKey: "numOfPetsLabelKey") as? String{
            numberOfPetsLabel.text = numOfPets
            morePetsStepper.value = Double(numOfPets)!
        }
        
        if (userDefaults.object(forKey: "yearKey") != nil){
            let yearNum = userDefaults.integer(forKey: "yearKey")
            yearSegmentedControl.selectedSegmentIndex = yearNum
            year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)!
        }

        if (userDefaults.object(forKey: "petSwitchKey") != nil){
            let onOrOff = userDefaults.bool(forKey: "petSwitchKey")
            morePetsSwitch.isOn = onOrOff
        }
        
        if let favoriteColor = userDefaults.object(forKey: "favColorKey") as? String {
            favColor = favoriteColor
            changeEdgesColor(colorType: favColor)
        }
        
        if let favoriteActivity = userDefaults.object(forKey: "favActivityKey") as? String {
            favActivity = favoriteActivity
            activityImage.image = UIImage(named: favActivity)
            activityImage.contentMode = .scaleToFill
        }
        
        if let favoriteMovie = userDefaults.object(forKey: "favMovieKey") as? String {
            favMovie = favoriteMovie
            movieImage.image = UIImage(named: favMovie)
            movieImage.contentMode = .scaleToFill
        }
        
        // Uncomment, if need to clear all UserDefault data
        if let bundleId = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleId)
        }
    }

    
    
    @IBAction func traitSegmentControlAction(_ sender: UISegmentedControl) {
        switch traitSegmentedControl.selectedSegmentIndex {
            case 0:
            chosenTrait = "Academy Engraved LET"
            chosenTraitSize = 20.0
            changeFontFamilyStyle(fontStyle: "Academy Engraved LET", fontSize: 20.0)
            case 1:
            chosenTrait = "Snell Roundhand"
            chosenTraitSize = 22.0
            changeFontFamilyStyle(fontStyle: "Snell Roundhand", fontSize: 22.0 )
            case 2:
            chosenTrait = "Arial Rounded MT Bold"
            chosenTraitSize = 17.0
            changeFontFamilyStyle(fontStyle: "Arial Rounded MT Bold", fontSize: 17.0)
            default:
                break
            }
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        numberOfPetsLabel.text = "\(Int(sender.value))"
        userDefaults.set(numberOfPetsLabel.text, forKey: "numOfPetsLabelKey")
    }
    
    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {
        
        
        year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)!
        
        var favoriteActivity = favActivity
        if favActivity == "Videogame" || favActivity == "Sports" {
            favoriteActivity = "play " + favoriteActivity
        }
        // Creating a String that hold our introduction.
        introduction = "Hello, my name is \(firstNameTextField.text!) \(lastNameTextField.text!) and I attend \(schoolNameTextField.text!). I am currently in my \(year) year and I own \(numberOfPetsLabel.text!) dogs. My favorite color is \(favColor).  It is \(morePetsSwitch.isOn) that I want more pets. During my free time I love to \(favoriteActivity). I also love watching movies, one of my favorite is \(favMovie). Thank you for watching."
        
        userDefaults.set(firstNameTextField.text, forKey: "firstNameKey")
        userDefaults.set(lastNameTextField.text, forKey: "lastNameKey")
        userDefaults.set(schoolNameTextField.text, forKey: "schoolNameKey")
        userDefaults.set(morePetsSwitch.isOn, forKey: "petSwitchKey")
        userDefaults.set(yearSegmentedControl.selectedSegmentIndex, forKey: "yearKey")
        
        performSegue(withIdentifier: "showPopUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showPopUp" {
            let destinationVC = segue.destination as? popUpViewController
            if let name = firstNameTextField.text {
                destinationVC?.firstName = name
            }
            destinationVC?.introduction = introduction
            destinationVC?.favColor = favColor
            destinationVC?.favActivity = favActivity
            destinationVC?.favMovie = favMovie
            destinationVC?.chosenTrait = chosenTrait
            destinationVC?.chosenTraitSize = chosenTraitSize
        }
    }
    
    func changeFontFamilyStyle(fontStyle style:String, fontSize size: CGFloat) {
        firstNameTextField?.font = UIFont(name: style, size: size)
        lastNameTextField?.font = UIFont(name: style, size: size)
        schoolNameTextField?.font = UIFont(name: style, size: size)
        
        firstNameLabel?.font = UIFont(name: style, size: size)
        lastNameLabel?.font = UIFont(name: style, size: size)
        schoolNameLabel?.font = UIFont(name: style, size: size)
        numberOfPetsLabel?.font = UIFont(name: style, size: size)
        academicYearLabel?.font = UIFont(name: style, size: size)
        pickTraitLabel?.font = UIFont(name: style, size: size)
        petsLabel?.font = UIFont(name: style, size: size)
        morePetsLabel?.font = UIFont(name: style, size: size)
        favColorLabel?.font = UIFont(name: style, size: size)
        favActivityLabel?.font = UIFont(name: style, size: size)
        favMovieLabel?.font = UIFont(name: style, size: size)
    }
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return colors.count
        case 1:
            return activities.count
        case 2:
            return movies.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return colors[row]
        case 1:
            return activities[row]
        case 2:
            return movies[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            favColor = colors[row]
            changeEdgesColor(colorType: favColor)
            userDefaults.set(favColor, forKey: "favColorKey")
        case 1:
            favActivity = activities[row]
            activityImage.image = UIImage(named: favActivity)
            activityImage.contentMode = .scaleToFill
            userDefaults.set(favActivity, forKey: "favActivityKey")
        case 2:
            favMovie = movies[row]
            movieImage.image = UIImage(named: favMovie)
            movieImage.contentMode = .scaleToFill
            userDefaults.set(favMovie, forKey: "favMovieKey")
        default:
            break
        }
    }
    
    func changeEdgesColor(colorType color: String){
        switch color {
        case "Red":
            self.view.backgroundColor = UIColor.red
            leftSideView.backgroundColor = UIColor.red
            rightSideView.backgroundColor = UIColor.red
        case "Blue":
            self.view.backgroundColor = UIColor.blue
            leftSideView.backgroundColor = UIColor.blue
            rightSideView.backgroundColor = UIColor.blue
        case "Green":
            self.view.backgroundColor = UIColor.green
            leftSideView.backgroundColor = UIColor.green
            rightSideView.backgroundColor = UIColor.green
        case "Yellow":
            self.view.backgroundColor = UIColor.yellow
            leftSideView.backgroundColor = UIColor.yellow
            rightSideView.backgroundColor = UIColor.yellow
        case "Pink":
            self.view.backgroundColor = UIColor.systemPink
            leftSideView.backgroundColor = UIColor.systemPink
            rightSideView.backgroundColor = UIColor.systemPink
        case "Purple":
            self.view.backgroundColor = UIColor.purple
            leftSideView.backgroundColor = UIColor.purple
            rightSideView.backgroundColor = UIColor.purple
        case "Black":
            self.view.backgroundColor = UIColor.black
            leftSideView.backgroundColor = UIColor.black
            rightSideView.backgroundColor = UIColor.black
        case "White":
            self.view.backgroundColor = UIColor.white
            leftSideView.backgroundColor = UIColor.white
            rightSideView.backgroundColor = UIColor.white
        case "Orange":
            self.view.backgroundColor = UIColor.orange
            leftSideView.backgroundColor = UIColor.orange
            rightSideView.backgroundColor = UIColor.orange
        default:
            break
        }
    }
}



