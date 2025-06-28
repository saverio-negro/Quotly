//
//  Tips.swift
//  Quotly
//
//  Created by Saverio Negro on 22/02/25.
//

import SwiftUI
import TipKit

struct RecognizeTextFromQuoteImageTip: Tip {
    var title: Text {
        Text("Select Your Favorite Quote")
    }
    
    var message: Text? {
        Text("You can grab the text from a quote image you saved in your photos and reflect on it.")
    }
    
    var image: Image? {
        Image(systemName: "quote.opening")
    }
}

struct VibesRatingTip: Tip {
    var title: Text {
        Text("Vibes Rating")
    }
    
    var message: Text? {
        Text("Quotly gives you a live feedback on how your memo sounds as you type.")
    }
    
    var image: Image? {
        Image(systemName: "heart.fill")
    }
}

struct FilterByDateTip: Tip {
    var title: Text {
        Text("Filter Your Memos")
    }
    
    var message: Text? {
        Text("Filter your memos by date.")
    }
    
    var image: Image? {
        Image(systemName: "calendar")
    }
}

struct FilterByTextTip: Tip {
    var title: Text {
        Text("Filter Your Memos")
    }
    
    var message: Text? {
        Text("Filter your memos by text.")
    }
    
    var image: Image? {
        Image(systemName: "magnifyingglass")
    }
}

struct EditMemoTip: Tip {
    var title: Text {
        Text("Edit Your Memo.")
    }
}
