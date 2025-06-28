//
//  QuoteImagePickerViewModel.swift
//  Quotly
//
//  Created by Saverio Negro on 16/02/25.
//

import SwiftUI
import PhotosUI
import Vision

extension Image {
    @MainActor
    func getCGImage() -> CGImage? {
        return ImageRenderer(content: self).cgImage
    }
}

@Observable
class QuoteImagePickerViewModel {
    var image: Image? = nil
    var imageSelection: PhotosPickerItem? = nil
    var recognizedQuoteStrings: [String]? = nil
    var quoteText: String? = nil
    var author: String? = nil
    
    @MainActor
    func loadImage() async throws -> Image? {
        if let imageSelection {
            do {
                return try await imageSelection.loadTransferable(type: Image.self)
            } catch {
                throw error
            }
        } else {
            print("No image selected.")
        }
        return nil
    }
    
    func recognizeQuoteTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let recognizedQuoteStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        self.recognizedQuoteStrings = recognizedQuoteStrings
    }
    
    @MainActor
    func performQuoteTextRecognition() async {
        if let cgImage = self.image?.getCGImage() {
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)
            
            let request = VNRecognizeTextRequest(completionHandler: recognizeQuoteTextHandler)
            
            do {
                try requestHandler.perform([request])
            } catch {
                print("Unable to perform the request: \(error.localizedDescription)")
            }
        }
    }
    
    func getRecognizedQuote() -> (text: String, author: String) {
        
        var piecesOfQuoteText = [String]()
        var authorText = ""
        
        if let unwrappedRecognizedQuoteStrings = self.recognizedQuoteStrings {
            
            for (index, text) in unwrappedRecognizedQuoteStrings.enumerated() {
                
                piecesOfQuoteText.append(text)
                
                if text.contains(".") {
                    if index + 1 < unwrappedRecognizedQuoteStrings.count {
                        authorText = unwrappedRecognizedQuoteStrings[index + 1]
                    }
                    break
                }
            }
        }
        
        let rawQuoteText = piecesOfQuoteText.joined(separator: " ")
        let cleanQuoteText = cleanTextFromQuote(rawQuoteText)
        let cleanAuthorText = cleanAuthorFromQuote(authorText)
        return (cleanQuoteText, cleanAuthorText)
    }
    
    func cleanTextFromQuote(_ rawText: String) -> String {
        var cleanQuoteText = ""
        
        for char in rawText {
            if !(char == "\\" || char == "\"") {
                cleanQuoteText += String(char)
            }
        }
        
        return cleanQuoteText
    }
    
    func cleanAuthorFromQuote(_ rawAuthor: String) -> String {
        var cleanQuoteAuthor = ""
        let hyphen = "-"
        let enDash = "–"
        let emDash = "—"
        
        func shouldSkip(_ char: String) -> Bool {
            return char == hyphen || char == enDash || char == emDash
        }
        
        for char in rawAuthor {
            if shouldSkip(String(char)) {
                continue
            }
            cleanQuoteAuthor += String(char)
        }
        return cleanQuoteAuthor
    }
}
