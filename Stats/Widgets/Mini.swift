//
//  Mini.swift
//  Stats
//
//  Created by Serhiy Mytrovtsiy on 14.06.2019.
//  Copyright © 2019 Serhiy Mytrovtsiy. All rights reserved.
//

import Cocoa

class Mini: NSView, Widget {
    var valueView: NSTextField = NSTextField()
    var labelView: NSTextField = NSTextField()
    
    var value: Float = 0
    var label: String = "" {
        didSet {
            self.labelView.stringValue = label
        }
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        self.wantsLayer = true
        
        let xOffset: CGFloat = 1.0
        
        let labelView = NSTextField(frame: NSMakeRect(xOffset, 13, self.frame.size.width, 7))
        labelView.textColor = NSColor.red
        labelView.isEditable = false
        labelView.isSelectable = false
        labelView.isBezeled = false
        labelView.wantsLayer = true
        labelView.textColor = .labelColor
        labelView.backgroundColor = .controlColor
        labelView.canDrawSubviewsIntoLayer = true
        labelView.alignment = .natural
        labelView.font = NSFont.systemFont(ofSize: 7, weight: .ultraLight)
        labelView.stringValue = self.label
        labelView.addSubview(NSView())
        
        let valueView = NSTextField(frame: NSMakeRect(xOffset, 3, self.frame.size.width, 10))
        valueView.textColor = NSColor.red
        valueView.isEditable = false
        valueView.isSelectable = false
        valueView.isBezeled = false
        valueView.wantsLayer = true
        valueView.textColor = .labelColor
        valueView.backgroundColor = .controlColor
        valueView.canDrawSubviewsIntoLayer = true
        valueView.alignment = .natural
        valueView.font = NSFont.systemFont(ofSize: 10, weight: .regular)
        valueView.stringValue = ""
        valueView.addSubview(NSView())
        
        self.labelView = labelView
        self.valueView = valueView
        
        self.addSubview(self.labelView)
        self.addSubview(self.valueView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redraw() {
        self.valueView.textColor = Float(self.value).usageColor()
        self.needsDisplay = true
        setNeedsDisplay(self.frame)
    }
    
    func value(value: Float) {
        if self.value != value {
            self.value = value
            
            self.valueView.stringValue = "\(Int(Float(Float(value).roundTo(decimalPlaces: 2))! * 100))%"
            self.valueView.textColor = Float(value).usageColor()
        }
    }
}