# 🦀 Rust + SwiftUI Static Library for iOS

This is a simple example showing how to build a static library in Rust and use it in a Swift-based iOS application — works for both real devices and simulators.

> ✅ Supports both Apple Silicon and Intel-based Macs  
> ✅ No CocoaPods, Carthage, or SwiftPM needed  
> ✅ Just Rust + Xcode + one clean `.a`

---

## Build Steps

This is a simple example of how to create a static library in Rust and use it in an iOS application.

> You can place your Rust project anywhere — this just assumes a `rust_add` project inside `static_libs/`.

### 1. Install required targets

```bash
rustup target add aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios
```

## 2. Build the Rust library

```bash
cargo build --release --target aarch64-apple-ios
cargo build --release --target aarch64-apple-ios-sim
cargo build --release --target x86_64-apple-ios
```

## 3. Create a folder to store the built libraries

```bash
mkdir -p ../built
```

## 4. Create a static library for iOS devices

```bash
libtool -static -o "../built/librust_add-iphoneos.a" \
    "target/aarch64-apple-ios/release/librust_add.a"

libtool -static -o "../built/librust_add-iphonesimulator.a" \
    "target/aarch64-apple-ios-sim/release/librust_add.a" \
    "target/x86_64-apple-ios/release/librust_add.a"
```

## 5. Delete the target folder (!IMPORTANT!)

```bash
rm -rf target
```

## 6. Create a header file for the Rust library

```bash
touch rust_add.h
```

```c
#ifndef RUST_ADD_H
#define RUST_ADD_H

#ifdef __cplusplus
extern "C" {
#endif

int add_numbers(int a, int b);

#ifdef __cplusplus
}
#endif

#endif // RUST_ADD_H
```

## 7. Create a Bridging Header

```bash
touch Rust_iOS-Bridging-Header.h
```

```c
#import "rust_add.h"
```


## 8. Add the Bridging Header to your Xcode project

### Build Settings - Swift Compiler - General

```plaintext
Objective-C Bridging Header - /Rust_iOS/Rust_iOS-Bridging-Header.h
```


## 9. Allow the simulator and your phone to link with these libraries dynamically

### Build Settings - Other Linker Flags -  (For Debug and Release - Any Architecture | Any SDK)
```plaintext
$(inherited) $(PROJECT_DIR)/Rust_iOS/static_libs/built/librust_add$(EFFECTIVE_PLATFORM_NAME).a
```


## 10. Thats it!

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        let result = add_numbers(10, 10)
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("\(result)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

```
