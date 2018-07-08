# iOSKonbiniAutomation - Page Object Model for XCUITest made easy
**iOSKonbiniAutomation** is result of working on multiple projects with XCUITest. I've seen multiple approaches and this is amalgamation of the bits that I liked the most. There is fair bit of inspiration by work of [Andrey Kozlov](https://github.com/RayAnd)
This project brings [page object model] (https://www.guru99.com/page-object-model-pom-page-factory-in-selenium-ultimate-guide.html) (or **POM** in short) approach to your projects. It also provides capability to build app transitions graph to be able to have automatic navigations from one screen to another.
You also get assortment of ways to select your elements thanks to convenience functions added as extensions to XCUIElement and XCUIElementQuery via **iOSBenrinaAutomationHelpers**

Adding **iOSKonbiniAutomation** to project is super easy using [Carthage](https://github.com/Carthage/Carthage) and you can start using it right away.

This project is using under the hood [iOSBenrinaAutomationHelpers](https://github.com/lochness42/iOSBenrinaAutomationHelpers) to make selections, element value settings, waiting etc. easier.

> Note: This project is targeting minimum iOS version 10.0 to support last two major iOS releases

# Installation
**iOSKonbiniAutomation** can be installed with [Carthage](https://github.com/Carthage/Carthage), so please make sure that you got this prerequisite installed. After getting Carthage, you can follow steps [here] (https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

Cartfile reference to this repository should be as follows:
```
github "lochness42/iOSKonbiniAutomation"
```
> Note: this will fetch also iOSBenrinaAutomationHelpers as dependency so don't forget to add those along with iOSKonbiniAutomation framework as it's necessary. 
# Use
Once you've successfully added **iOSKonbiniAutomation** to your project, you can start using your convenience functions by adding to the header of your file:
```
import iOSKonbiniAutomation
import iOSBenrinaAutomationHelpers
```
Once this is done, all convenience functions and new TestCase and Screen objects are exposed for your use.

I'm working on demo application which will show how to use this framework easily.

# Contribution
Please feel free to fork, create pull requests and to open issues for any discovered issues or suggestions for additions. I really appreciate everyone's input as I would like to make test automation less painful for all people.

# Acknowledgement
Big thanks to [Andrey Kozlov](https://github.com/RayAnd) who inspired quite a bit of my work and had good discussions about how to approach this.

# Author
lochness42, lochness42@gmail.com
