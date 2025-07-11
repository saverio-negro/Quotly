# Quotly

<img src="./Images/quotly-1.png" width="25%"/> <img src="./Images/quotly-2.png" width="25%"/> <img src="./Images/quotly-3.png" width="25%"/>

## Introduction

Quotly is an app I truly hold dear to. It's a tool I heartedly developed to serve inspiration and motivation in people's life. "Quotly" tries to enhance self-awareness in a world that is continuously fast-pacing, and spark motivation and inspiration by allowing the user to write little reflections (memos) on a daily motivational quote; specifically, one reflection for each daytime. The quote is meant to accompany the user througout their day.

## Description and Technologies Used

When developing “Quotly”, one of the crucial aspects I thought of was to make users feel as cozy and as less overwhelmed as possible. They would have to immediately be served up with a daily quote to bring with them throughout the day and write a simple reflection/memo per daytime.

#### `JSONDecoder` and `Date`

As far as the daily quotes, I have worked with both the `Codable` protocol and the `JSONDecoder` class to decode a local json file — where the app holds all the data that it needs for its daily quotes — into instances of codable `Quote` structs.

Also, the app hugely relies on the `Date` structure. It plays a central role around the topic of self-awareness.

In fact, I built a custom weekly calendar that revolves around this idea of self-awareness: I was able to write an algorithm using the `Date` struct to come up with a logic to specifically compute the exact week depending on the current day.

On top of that, to stick with this idea of inner-presence and self-awareness, I used the `Date` struct to program the calendar so that any future date is inaccessible until the new day has come.

The “Morning”, “Afternoon”, and “Evening” buttons also work with dates: the app makes sure that successive day times are locked until the next time window opens (e.g., afternoon comes) — yet another feature which is meant to have the user focus on the present arc of the day, and which distinguishes this app from any other apps centered on quotes.

#### Persisting `Memo` Objects with `SwiftData`

Then, I worked with `SwiftData`, which I needed to persistently store `Memo` objects, which I then query in the `MemosView` — sorted by date. In this view, I offer the user the possibility to filter their memos either by date, or by searching any containing text. To achieve those filter operations I implemented two simple methods within the `MemosViewModel` to be called for each of the already-queried `Memo` entries.

#### Sentiment Analysis and Text Recognition

Ultimately, I added a simple sentiment analysis using the `NaturalLanguage` framework in both the `AddMemoView` and `MemoView`. Precisely, I used a `NLTagger` taking the `.sentimentScore` option as the tag scheme. I then created a separate view called `VibesRatingView`, which takes in the sentiment score from the memo text, and with a simple logic shows as many filled hearts (up to five) according to the sentiment score. I thought it’d be a gentle and non-invasive way of providing users with a little live feedback to accompany them throughout their self-reflection, and possibly beware them as they type.

Last but not least, I worked with the `PhotoUI` framework to access the user’s library and for them to pick a quote image, and the `Vision` framework for its text-recognition. This is yet another important feature I hold dear to, because it enhances the user experience and revolves around the main purpose of my app: allowing the user to fully experience any inspirational and motivational quote they may bump into and wish to reflect on; however, what usually happens is that they would take a screenshot of it to save, but often end up forgetting it.
That’s where “Quotly” comes into play; in fact, it allows users for a one-time chance per day to upload their quote picture, grab its text, and replace it with the current daily quote; otherwise, they can start reflecting on the one the app gives them per that specific day.

That way, they don’t have to wait until they randomly bump into that quote on the app; instead, they are gently invited to get accompanied by their favorite quote throughout the day, enhancing their experience.

#### UI/UX Details to Self-Accomplishment

Another important and final aspect to this app is the tiny rewarding moments spread inside, which are essentially part of the theme per se: the little checks for each daytime as they get filled, or the highlights on each daytime symbol to mark completion on the “Memos” page, or the hearts conveying their memo’s vibes were all designed to make the user feel satisfied and taken care of. I designed them while paying attention to keeping the app pretty simple and cozy.

## License

This project is <a href="./LICENSE.md">licensed</a> under the **Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License (CC BY-NC-ND 4.0)**.
