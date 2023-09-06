//
//  ViewController.swift
//  UISliderCat
//
//  Created by Howe on 2023/9/4.
//

import UIKit

var currentView: UIView!



class ViewController: UIViewController {
    
    @IBOutlet weak var catInBoxImageView: UIImageView!
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var boxView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    @IBOutlet weak var catOrBoxSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet var RGBACSliderOutlet: [UISlider]!
    
    
    @IBOutlet var Labels: [UILabel]!
    
    
    @IBOutlet weak var radiusSwitchOutlet: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUp()
        currentView = catView
        
        
    }
    
    func setUp () {
        let catImage = UIImage(named: "Cat")
        let catImageView = UIImageView(image: catImage)
        catImageView.frame = catView.bounds
        catImageView.contentMode = .scaleAspectFit
        catView.mask = catImageView
        
        
        
        let boxImage = UIImage(named: "box")
        let boxImageView = UIImageView(image: boxImage)
        boxImageView.frame = boxView.bounds
        boxImageView.contentMode = .scaleAspectFit
        boxView.mask = boxImageView
        
        
        
        for z in 0...2 {
            Labels[z].text = "255"
        }
        Labels[3].text = "1.0"
        Labels[4].text = "0"
        
        
    }
    
    
    @IBAction func SliderValueChange(_ sender: UISlider) {
        switch sender.tag {
        case 50, 51, 52, 53:
            currentView.backgroundColor = UIColor( red: CGFloat(RGBACSliderOutlet[0].value) / 255, green: CGFloat(RGBACSliderOutlet[1].value) / 255, blue: CGFloat(RGBACSliderOutlet[2].value) / 255, alpha: CGFloat(RGBACSliderOutlet[3].value)
            )
            if sender.tag == 53 {
                if RGBACSliderOutlet[3].value == 0 {
                    catInBoxImageView.image = UIImage(named: "box"); catView.isHidden = true
                    
                } else {
                    catInBoxImageView.image = UIImage(named: "Cat in box"); catView.isHidden = false
                }
            }
            
            if sender.tag >= 50 && sender.tag <= 52 {
                Labels[sender.tag - 50].text = String(Int(sender.value))
            } else if sender.tag == 53 {
                Labels[3].text = String(format: "%.1f", sender.value)
            }
        case 54 :
            backgroundView.layer.cornerRadius = CGFloat(RGBACSliderOutlet[4].value)
            Labels[4].text = String(Int(sender.value))
        default:
            print("what?!")
        }
    }
    
    
    @IBAction func random(_ sender: UIButton) {
        let randomRed = Float.random(in: 0...255)
        let randomGreen = Float.random(in: 0...255)
        let randomBlue = Float.random(in: 0...255)
        let randomConnerRaidus = Float.random(in: 0...200)
        
        RGBACSliderOutlet[0].setValue(randomRed, animated: true)
        RGBACSliderOutlet[1].setValue(randomGreen, animated: true)
        RGBACSliderOutlet[2].setValue(randomBlue, animated: true)
        RGBACSliderOutlet[4].setValue(randomConnerRaidus, animated: true)
        
        var randomAlpha: Float = 1.0
        if radiusSwitchOutlet.isOn {
            randomAlpha = Float.random(in: 0.0...1.0)
            RGBACSliderOutlet[3].setValue(randomAlpha, animated: true)
            
        }
        currentView.backgroundColor = UIColor(red: CGFloat(randomRed) / 255, green: CGFloat(randomGreen) / 255, blue: CGFloat(randomBlue) / 255, alpha: CGFloat(randomAlpha))
        backgroundView.layer.cornerRadius = CGFloat(randomConnerRaidus)
        
        Labels[0].text = String(Int(randomRed))
        Labels[1].text = String(Int(randomGreen))
        Labels[2].text = String(Int(randomBlue))
        Labels[3].text = String(format: "%.1f", randomAlpha)
        Labels[4].text = String(Int(randomConnerRaidus))
    }
    
    
    @IBAction func reset(_ sender: Any) {
        reset()
    }
    
    func reset () {
        currentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        for i in 0...2 {
            RGBACSliderOutlet[i].setValue(255.0, animated: true)
        }
        
        RGBACSliderOutlet[3].setValue(1.00, animated: true)
        RGBACSliderOutlet[4].setValue(0, animated: true)
        backgroundView.layer.cornerRadius = 0
        setUp()
    }
    
    
    
    
    @IBAction func switchAlpha(_ sender: UISwitch) {
        RGBACSliderOutlet[3].isEnabled = sender.isOn
    }
    
    
    @IBAction func catOrboxsegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // Assuming "cat" is the first segment
            currentView = catView
            
        case 1: // Assuming "box" is the second segment
            currentView = boxView
            reset()
        default:
            break
        }
    }
    
}

