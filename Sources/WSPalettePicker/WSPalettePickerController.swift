//
//  WSPalettePickerController.swift
//  Mine
//
//  Created by Will Smillie on 12/4/20.
//  Copyright © 2020 Red Door Endeavors. All rights reserved.
//

import UIKit

public protocol WSPalettePickerDataSource {
    func palettePickerColors(pickerController: WSPalettePickerController) -> [UIColor]
}

public protocol WSPalettePickerDelegate {
    func palettePickerShouldPresent(pickerController: WSPalettePickerController)
    func pickerDidSelect(color: UIColor)
}

@available(iOS 13, *)
public class WSPalettePickerController: UIViewController, UIPopoverPresentationControllerDelegate {

    public var dataSource: WSPalettePickerDataSource?
    public var delegate: WSPalettePickerDelegate?

    var sender: WSPalettePickerButton? {
        didSet {
            modalPresentationStyle = .popover;
            preferredContentSize = CGSize.init(width: 300, height: 64)

            popoverPresentationController!.delegate = self
            popoverPresentationController!.sourceView = sender
            popoverPresentationController!.sourceRect = sender!.bounds
            popoverPresentationController!.permittedArrowDirections = .any;
        }
    }
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: WSPalettePickerLayoutFlow.init())
    
    var colors: [UIColor] {
        get {
            return (dataSource?.palettePickerColors(pickerController: self))!
        }
    }
            
    public override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(WSPalettePickerSwachCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])

        collectionView.reloadData()
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: Collection View
extension WSPalettePickerController : UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WSPalettePickerSwachCell
        cell.color = colors[indexPath.row]
        cell.isSelected = cell.color == sender?.currentColor
        if cell.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)

        let color = colors[indexPath.row]
        sender?.currentColor = color
        self.delegate?.pickerDidSelect(color: color)
    }
}



// MARK: Layout
@available(iOS 13, *)
@objc public class WSPalettePickerLayoutFlow: UICollectionViewFlowLayout {
    @objc override init() {
        super.init()
        scrollDirection = .horizontal
        minimumInteritemSpacing = 8
        sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.top + sectionInset.bottom + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + minimumInteritemSpacing
        let itemWidth = (collectionView.bounds.size.height - marginsAndInsets)
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    public override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
