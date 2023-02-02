//
//  DesTextField.swift
//  PADC-Grocery-App
//
//  Created by Ye Yint Aung on 24/11/2022.
//

import SwiftUI

struct DesTextField: View {
    @Binding var textValue: String
    var body: some View {
        TextField("Enter Description",text: $textValue)
            .padding([.leading,.trailing],10)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray)
            )
    }
}

struct DesTextField_Previews: PreviewProvider {
    static var previews: some View {
        DesTextField(textValue: .constant(""))
    }
}
