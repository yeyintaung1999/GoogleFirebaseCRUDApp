//
//  NameTextField.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 24/11/2022.
//

import SwiftUI

struct NameTextField: View {
    @Binding var textValue: String
    var body: some View {
        TextField("Enter Product Name",text: $textValue)
            .padding([.leading,.trailing],10)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray)
            )
    }
}

struct NameTextField_Previews: PreviewProvider {
    static var previews: some View {
        NameTextField(textValue: .constant(""))
    }
}
