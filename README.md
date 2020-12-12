# WSPalettePicker
An elegant color picker that allows a predefined set of colors to be selected.

<img src="imgs/demo.gif" height="400"/>
Please ignore the awful compresssion in the .gif. It looks nice, I swear

# Installation
You can use this component by adding it via Swift Package Manager, or downloading it and manually adding it to your project.

# Example
 
```
import UIKit
import WSPalettePicker

class ViewController: UIViewController, WSPalettePickerDelegate, WSPalettePickerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Picker Button
        let pickerButton = WSPalettePickerButton.init()
        pickerButton.frame = .init(x: 0, y: 0, width: 50, height: 50)
        pickerButton.center = view.center
        pickerButton.controller.delegate = self
        pickerButton.controller.dataSource = self
        pickerButton.currentColor = #colorLiteral(red: 0.851, green: 0.388, blue: 0.427, alpha: 1.0)
        view.addSubview(pickerButton)
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

```
