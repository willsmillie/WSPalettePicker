//
//  ViewController.swift
//  iOS Example
//
//  Created by Will Smillie on 12/12/20.
//

import UIKit
import WSPalettePicker

class ViewController: UIViewController, WSPalettePickerDelegate, WSPalettePickerDataSource {
    
    @IBOutlet weak var pickerButton: WSPalettePickerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerButton.controller.delegate = self
        pickerButton.controller.dataSource = self
        pickerButton.currentColor = #colorLiteral(red: 0.851, green: 0.388, blue: 0.427, alpha: 1.0)
    }
    
    // MARK: Palette Data Source
    
    func palettePickerColors(pickerController: WSPalettePickerController) -> [UIColor] {
        return [#colorLiteral(red: 0.659, green: 0.741, blue: 0.447, alpha: 1.0), #colorLiteral(red: 0.851, green: 0.388, blue: 0.427, alpha: 1.0), #colorLiteral(red: 0.906, green: 0.675, blue: 0.329, alpha: 1.0), #colorLiteral(red: 0.192, green: 0.451, blue: 0.149, alpha: 1.0), #colorLiteral(red: 0.976, green: 0.831, blue: 0.0, alpha: 1.0), #colorLiteral(red: 0.322, green: 0.227, blue: 0.212, alpha: 1.0), #colorLiteral(red: 0.937, green: 0.58, blue: 0.576, alpha: 1.0), #colorLiteral(red: 0.459, green: 0.565, blue: 0.584, alpha: 1.0)]
    }
    
    // MARK: Palette Delegate
    
    func palettePickerShouldPresent(pickerController: WSPalettePickerController) {
        self.present(pickerController, animated: true)
    }
    
    func pickerDidSelect(color: UIColor) {
        print("Selected \(color)")
    }

}

