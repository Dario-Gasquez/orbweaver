# Orbweaver
Orbweaver is a simple, Swift based, iOS networking library that leverages [URLSession](https://developer.apple.com/documentation/foundation/urlsession). It supports UIKit as well as SwiftUI/Combine based applications. For more information about the underlying design check:
[Orbweaver design](https://github.com/Dario-Gasquez/orbweaver/wiki).
 
## Requirements
- iOS 13.0+
- Swift 5.0+
- Xcode 13.0+

## Install Instructions

### Swift Package Manager

---

**NOTE:**
These instructions are based on Xcode 13.4.1, the steps may deffer for different Xcode versions.

---

1 . Open your project and add a package dependency as you prefer (for example: right click on the project -> *Add Packages* or from the project's *Package Dependencies* tab).

2 . Paste the following in the package URL field:  
`https://github.com/Dario-Gasquez/orbweaver`

3 . Follow the instructions until the **Orbweaver** package is added to the project  

Once the package was succesfully added you should be able to access it by importing the module:
```swift
import Orbweaver
```


## Demo Apps
In [DemoApps](https://github.com/Dario-Gasquez/orbweaver/tree/demo-app/DemoApps) you'll find a SwiftUI/Combine demo application (**OrbweaverSUI**) that shows how to integrate **Orbweaver**. It retrieves cat facts from https://catfact.ninja and shows them in a list.
