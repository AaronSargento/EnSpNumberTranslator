//
//  ViewController.swift
//  Homework 3
//
//  Created by Aaron Sargento on 1/30/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: User will use the picker enter a combination consisting of a number, its English word, and its Spanish word. Number choices are 0-9. User can determine whether they want the program to be in English or Spanish with the switch.
// Output: If the user enters the correct combination, a message will show the combination and it will be read out loud in the chosen language. If the user enters an incorrect combination, a message will be displayed to enter a good combination and it will be read out loud in the chosen language.

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var AppTitle: UILabel!
    
    @IBOutlet weak var NumberPicker: UIPickerView!
    
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBOutlet weak var EngSpaLabel: UILabel!
    
    @IBOutlet weak var SpaEngLabel: UILabel!
    
    @IBOutlet weak var LangSwitch: UISwitch!
    
    
    let NumberData = [["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"], ["Cero", "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve"], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]]
    
    /*
        The user can determine whether they want the instruction to be in English or Spanish
    */
    @IBAction func MessageSwitch(_ sender: Any) {
        if LangSwitch.isOn {
            outcomeLabel.text = "Please enter a same number combination"
        }
        else {
            outcomeLabel.text = "Introduzca una misma combinación de números"
        }
    }
    
    /*
        Determine the number of components in the pickerview
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return NumberData.count
    }
    
    /*
        Determine the amount of rows per component in the picker
    */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return NumberData[component].count
    }
    
    /*
        Return the title for each item based on the component and row
    */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return NumberData[component][row]
    }
    
    /*
        Used to select the item based on the component and row.
        It will call outCome() to edit the outcomeLabel and have that text read in the chosen language.
    */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        outCome()
    }
    
    /*
        This function will change the font for the pickerView.
        It will edit the text color, font, font size, display the text, and center it.
    */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = NumberData[component][row]
        pickerLabel.font = UIFont(name: "Chalkboard SE", size: 28)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    
    /*
        This function will do the following;
        It will grab an english word, spanish word, and a number.
        If entry is in the same row, then the entry will be displayed in the outcomeLabel and it will be read.
        If not in the same row, then user will be prompted to try again in the outcomeLabel and that message will be read.
        Based on the current position of the switch, the message will either be in English or Spanish
     */
    func outCome()  {
        let englishSet = NumberData[0][NumberPicker.selectedRow(inComponent: 0)]
        let spanishSet = NumberData[1][NumberPicker.selectedRow(inComponent: 1)]
        let numberSet = NumberData[2][NumberPicker.selectedRow(inComponent: 2)]
        
        let speechSythesizers = AVSpeechSynthesizer()
        
        var speechUtterance = AVSpeechUtterance()
        
        speechUtterance.rate = 0.75
        
        var voice = AVSpeechSynthesisVoice()
        
        //if items are in the same row then display the text
        let englishRow = NumberPicker.selectedRow(inComponent: 0)
        let spanishRow = NumberPicker.selectedRow(inComponent: 1)
        let numberRow = NumberPicker.selectedRow(inComponent: 2)
        
        if (englishRow == spanishRow) && (englishRow == numberRow)  {
            // switch == on -> Eng to Esp
            if LangSwitch.isOn {
                outcomeLabel.text = englishSet + ", " + spanishSet + ", " + numberSet
                speechUtterance = AVSpeechUtterance(string: englishSet + ", " + spanishSet + ", " + numberSet)
                voice = AVSpeechSynthesisVoice(language: "en-EN")!
            }
            // switch != -> Esp to Eng
            else {
                outcomeLabel.text = spanishSet + ", " + englishSet + ", " + numberSet
                speechUtterance = AVSpeechUtterance(string: spanishSet + ", " + englishSet + ", " + numberSet)
                voice = AVSpeechSynthesisVoice(language: "es-MX")!
            }
        } else {
            // swith == on -> Eng
            if LangSwitch.isOn {
                outcomeLabel.text = "Please enter a same number combination"
                speechUtterance = AVSpeechUtterance(string: "Please enter a same number combination")
                voice = AVSpeechSynthesisVoice(language: "en-EN")!
            }
            // switch != on -> Esp
            else {
                outcomeLabel.text = "Introduzca una misma combinación de números"
                speechUtterance = AVSpeechUtterance(string: "Introduzca una misma combinación de números")
                voice = AVSpeechSynthesisVoice(language: "es-MX")!
            }
        }
        speechUtterance.voice = voice
        speechSythesizers.speak(speechUtterance)
    }
    
    /*
     When called this function will format the object (label or picker) to a rounder shape and give it a brown border
     */
    func formatObject(_ sender: AnyObject) {
        sender.layer.borderColor = UIColor.brown.cgColor
        sender.layer.borderWidth = 5
        sender.layer.masksToBounds = true
        sender.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the Picker as a delegate and dataSource in the View Controller
        NumberPicker.delegate =  self
        NumberPicker.dataSource = self
        
        //format our objects
        formatObject(AppTitle)
        formatObject(NumberPicker)
        formatObject(outcomeLabel)
        formatObject(EngSpaLabel)
        formatObject(SpaEngLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

