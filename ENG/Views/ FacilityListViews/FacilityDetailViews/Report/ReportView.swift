//
//  ReportView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI

struct ReportView: View {
    
    @State var reportTitleTextField: String = ""
    @State var reportType: String = ""
    @State var reportContentTextField: String = ""
    @State var placeHolderTextField: String = "글 내용을 입력하세요. (500자 이내)"
    @FocusState var reportContentTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 19) {
            TextField("제목을 입력해주세요.", text: $reportTitleTextField)
                .customTextField(padding: 15)
                .padding(.horizontal, 16)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
            
            ZStack {
                TextField("신고 종류를 선택해주세요.", text: $reportType)
                    .customTextField(padding: 15)
                    .disabled(true)
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
                    .padding(.horizontal, 16)
                Menu {
                    // 신고 타입 회의 필요
                    Button("누수 신고", action: { reportType = "누수 신고" })
                    Button("외벽 균열 신고", action: { reportType = "외벽 균열 신고" })
                    Button("전기 설비 이상 신고", action: { reportType = "전기 설비 이상 신고" })
                    Button("소화 설비 이상 신고", action: { reportType = "소화 설비 이상 신고" })
                    Button("기타", action: { reportType = "기타" })
                } label: {
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 12, height: 12, alignment: .center)
                }
                .frame(width: UIScreen.main.bounds.width - 32, alignment: .trailing)
                .padding(.trailing, 30)
            }
            
            HStack(spacing: 44) {
                // 갤러리 및 카메라에 접근하여 업로드 가능하도록.
                Rectangle()
                    .frame(width: 90, alignment: .center)
                Rectangle()
                    .frame(width: 90, alignment: .center)
                Rectangle()
                    .frame(width: 90, alignment: .center)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 90, alignment: .center)
            
            ZStack {
                if reportContentTextField.isEmpty {
                    TextEditor(text: $placeHolderTextField)
                        .padding(.all, 16)
                        .foregroundColor(Color.theme.secondary)
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .disabled(true)
                        .customTextField(padding: 0)
                }
                TextEditor(text: $reportContentTextField)
                    .padding(.all, 16)
                    .foregroundColor(Color.black)
                    .lineSpacing(5)
                    .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .customTextField(padding: 0)
                    .opacity(reportContentTextFieldFocused || !reportContentTextField.isEmpty ? 1 : 0.1)
                    .focused($reportContentTextFieldFocused)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("신고하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            // 등록 기능
        }, label: {
            Text("등록")
                .font(.custom(Font.theme.mainFontBold, size: 16))
        }))
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView()
        }
    }
}