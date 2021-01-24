//
//  ColorPickerPro.swift
//  Julia Set Renderer
//
//  Created by Hezekiah Dombach on 11/23/20.
//  Copyright © 2020 Hezekiah Dombach. All rights reserved.
//

import SwiftUI

struct ColorPickerPro: View {
	@Binding var color: SIMD3<Float>
	@State var tempColor: SIMD3<Float> = .init(1, 1, 1)
    var body: some View {
		HStack {
			VStack {
				HStack {
					NumberInput(value: $tempColor.x.nsNumber, step: 0.01.nsNumber.0, name: "R")
					Slider(value: $tempColor.x)
				}
				HStack {
					NumberInput(value: $tempColor.y.nsNumber, step: 0.01.nsNumber.0, name: "G")
					Slider(value: $tempColor.y)
				}
				HStack {
					NumberInput(value: $tempColor.z.nsNumber, step: 0.01.nsNumber.0, name: "B")
					Slider(value: $tempColor.z)
				}
			}
				.frame(width: 200)
			VStack {
				RoundedRectangle(cornerRadius: 10)
					.frame(width: 50, height: 50)
					.foregroundColor(Color.init(red: Double(tempColor.x), green: Double(tempColor.y), blue: Double(tempColor.z), opacity: 1))
				Button("Set") {
					color = tempColor
				}
			}
		}
    }
}

struct ColorPickerPro_Previews: PreviewProvider {
    static var previews: some View {
		ColorPickerPro(color: Binding.init(get: {
			Engine.Settings.skyBox[0].color
		}, set: { (newColor) in
			Engine.Settings.skyBox[0].color = newColor
		}))
    }
}
