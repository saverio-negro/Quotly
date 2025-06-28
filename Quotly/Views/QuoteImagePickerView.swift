//
//  QuoteImagePickerView.swift
//  Quotly
//
//  Created by Saverio Negro on 16/02/25.
//

import SwiftUI
import PhotosUI
import TipKit

struct QuoteImagePickerView: View {
    
    @Environment(WeekDaysViewModel.self) var weekDaysViewModel
    
    @Bindable var quoteImagePickerViewModel = QuoteImagePickerViewModel()
    
    @Binding var selectedWeekDay: Int
    
    @State var isAlertPresented = false
    
    let recognizeTextFromQuoteImageTip = RecognizeTextFromQuoteImageTip()
    
    var body: some View {
        PhotosPicker(selection: $quoteImagePickerViewModel.imageSelection, photoLibrary: .shared()) {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .font(.title)
                .padding(10)
                .background(.aquamarine)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(.lightBlue)
                }
        }
        .popoverTip(RecognizeTextFromQuoteImageTip())
        .onChange(of: quoteImagePickerViewModel.imageSelection) {
            Task {
                if let loadedImage = try? await (quoteImagePickerViewModel.loadImage()) {
                    quoteImagePickerViewModel.image = loadedImage
                    
                    // Use text recognition to extract quote text from image
                    await quoteImagePickerViewModel.performQuoteTextRecognition()
                    
                    // Get recognized quote after cleaning up
                    let recognizedQuote = quoteImagePickerViewModel.getRecognizedQuote()
                    let quote = Quote(
                        author: recognizedQuote.author,
                        text: recognizedQuote.text
                    )
                    
                    // Set the newly recognized quote as the new quote for the weekday
                    weekDaysViewModel.setQuote(for: selectedWeekDay, quote: quote)
                }
            }
        }
    }
}

#Preview {
    QuoteImagePickerView(selectedWeekDay: .constant(3))
        .environment(WeekDaysViewModel())
}
