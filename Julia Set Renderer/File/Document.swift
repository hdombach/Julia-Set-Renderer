//
//  Document.swift
//  Julia Set Renderer
//
//  Created by Hezekiah Dombach on 3/30/21.
//  Copyright © 2021 Hezekiah Dombach. All rights reserved.
//

import Cocoa
import Foundation
import Swift
import SwiftUI
import MetalKit

class Document: NSDocument {
	
	@objc var content = Content()
	
	var graphics: Graphics!
	
	var container: VoxelContainer!
	
	var viewState: ViewSate!
	
	var view: RenderView!
	
	override init() {
		super.init()
		graphics = Graphics(doc: self)
		graphics.setUp()
		container = VoxelContainer(doc: self)
		viewState = ViewSate(doc: self)
		view = RenderView(doc: self)
		viewState.view = view
		
		content.viewState = viewState
	}
	
	//enable autosave
	override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
		return true
	}
	
	//Make ui stuff
	override func makeWindowControllers() {
		/*let storyboard = NSStoryboard(name: "Main", bundle: nil)
		if let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Viewport Window Controller")) as? NSWindowController {
			addWindowController(windowController)
			
		}*/
		let viewPortWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 300), styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView], backing: .buffered, defer: false)
		viewPortWindow.isReleasedWhenClosed = false
		viewPortWindow.contentView = view
		
		
		let viewWindowController = NSWindowController(window: viewPortWindow)
		
		let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 300), styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView], backing: .buffered, defer: false)
		window.isReleasedWhenClosed = false;
		window.center()
		window.contentView = NSHostingView(rootView: ContentView(doc: self))
		
		let windowController = NSWindowController(window: window)
		self.addWindowController(windowController)
		
		self.addWindowController(viewWindowController)
	}
	
	override class var autosavesInPlace: Bool {
		return true
	}
	
	//write
	override func data(ofType typeName: String) throws -> Data {
		let encoder = JSONEncoder()
		return try encoder.encode(content)
		// Insert code here to write your document to data of the specified type, throwing an error in case of failure.
		// Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
		
		//throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}
	
	override func read(from data: Data, ofType typeName: String) throws {
		let decoder = JSONDecoder()
		content = try decoder.decode(Content.self, from: data)
		content.viewState = viewState
		graphics.setUp()
		
		
		// Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
		// Alternatively, you could remove this method and override read(from:ofType:) instead.
		// If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
		
		//throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}
}
