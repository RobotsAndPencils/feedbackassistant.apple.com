# Unclear how to implement my own Publisher and Subscription

FB6311954

## Please provide a descriptive title for your feedback:

Unclear how to implement my own Publisher and Subscription

## Which area are you seeing an issue with?

Combine Framework

## What type of feedback are you reporting?

Suggestion

## Please describe the issue and what steps we can take to reproduce it:

I would like to have something like Publishers.Future with the ability to describe cancellation work that should be invoked when a subscriber cancels its subscription (FB6311565). I attempted to implement my own Publisher and Subscription to do this, but had a difficult time understanding the contract that needs to be implemented beyond simply conforming to those protocols. The resources I found that were helpful were this thread on the Swift forums: https://forums.swift.org/t/a-uicontrol-event-publisher-example/26215 and this 3rd party summary https://heckj.github.io/swiftui-notes/. I've attached the solution that I came up with, but the way I arrived at that implementation was more "iterate until it both compiles and works with manual testing" than "implement based on an understanding of the underlying principles", so I wouldn't use this in shipping software. That being said, I'd like to see more documentation and examples of how users of Combine should implement their own Publishers when it's necessary for them to do so.

