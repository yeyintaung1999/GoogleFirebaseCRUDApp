//
//  PriceTextField.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 24/11/2022.
//

import SwiftUI

struct PriceTextField: View {
    @Binding var textValue: String
    var body: some View {
        TextField("Enter Price",text: $textValue)
            .keyboardType(.numberPad)
            .padding([.leading,.trailing],10)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray)
            )
    }
}

struct PriceTextField_Previews: PreviewProvider {
    static var previews: some View {
        PriceTextField(textValue: .constant(""))
    }
}
