//
//  MandelbulbSettings.swift
//  Julia Set Renderer
//
//  Created by Hezekiah Dombach on 11/27/20.
//  Copyright © 2020 Hezekiah Dombach. All rights reserved.
//

import SwiftUI

struct MandelbulbSettings: View {
	@Binding var settings: RayMarchingSettings
	
    var body: some View {
		VStack {
			Input(value: $settings.mandelbulbPower, step: 0.1, name: "Power")
			Input(value: $settings.bundleSize, step: 1, name: "Bundle Size")
			Input(value: $settings.quality, step: 100, name: "Quality")
			Input(value: $settings.colorOffset, step: 0.01, name: "Color Offset")
			Input(value: $settings.iterations, step: 1, name: "Iterations")
		}.padding()
    }
}

struct MandelbulbSettings_Previews: PreviewProvider {
    static var previews: some View {
		MandelbulbSettings(settings: Binding.init(get: {
			Engine.Settings.rayMarchingSettings
		}, set: { (newSettings) in
			Engine.Settings.rayMarchingSettings = newSettings
		}))
    }
}
