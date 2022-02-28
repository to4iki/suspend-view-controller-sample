# suspend-view-controller-sample

Suspend between UIViewController.present and UIViewController.didDisapper.

## About
sample code for [slide](https://speakerdeck.com/to4iki/suspendable-view-controller)

## Demo
[Concurrency — The Swift Programming Language \(Swift 5\.6\)](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) > Task Cancellation

### 1. Task.checkCancellation
Throwing an error like CancellationError

https://user-images.githubusercontent.com/2172769/158025246-00fa8fdc-f25e-4442-b5f0-0644e3bff068.mov

### 2. Task.isCancelled
Returning void

https://user-images.githubusercontent.com/2172769/158025245-93bbe7fd-3871-4c6d-afd6-f14bb4724a34.mov

### 3. withTaskCancellationHandler
perform dismiss UIViewController with cancellation handler

https://user-images.githubusercontent.com/2172769/158025239-9f959c9c-205a-4378-aa7c-55aaef165ba7.mov

## Requirements
Requires Swift5.5 and Xcode13.2 or later.
