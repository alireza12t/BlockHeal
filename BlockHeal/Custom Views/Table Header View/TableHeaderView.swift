//
//  tableHeaderViewViewController.swift
//  BlockHeal
//
//  Created by ali on 6/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit


@IBDesignable
class TableHeaderView: UIView {
    
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        Log.i()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.i()

        nibSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Log.i()

        nibSetup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        Log.i()

        nibSetup()
        tableHeaderView?.prepareForInterfaceBuilder()
    }

    //MARK:- Lifecycle methods
    private func nibSetup() {
        Log.i()

        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        tableHeaderView = view
    }

    func loadViewFromNib() -> UIView? {

        let nibName = String(describing: TableHeaderView.self)
        Log.i("load nibName => \(nibName)")

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
//        NSBundle.mainBundle().loadNibNamed("SomeView", owner: self, options: nil)

        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
      func configure(title: String) {
            Log.i()

            titleLabel.text = title

        }

}
