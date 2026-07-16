

Adaptive Shimmer provides easy shimmer effect to any child widget with the facility to turn and off shimmer anytime to save lot of code duplication and extra codes

[<img alt="Network Image" height="50" src="https://cdn.buymeacoffee.com/uploads/project_updates/2023/12/08f1cf468ace518fc8cc9e352a2e613f.png" width="180"/>](https://www.buymeacoffee.com/abhijithsabudev)
## Getting started

Adaptive shimmer is able to mock the shape of its child widget, shimmer colors, loop, animation duration, direction of shimmer etc are customisable

##  Features
Supports Android, IOS, Linux, MACOS, WEB, Windows

## Usage

AdaptiveShimmer can be used for minimal coding and easy implementation of shimmer effects in your applications and provide interactive UI

<p>  
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYm45anpraGVyanplOTE0aXlnOXpwZDgxcDlhYXJyMWphaWtsMjl4dSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/4tpPOqTLjEAr9WmwG6/giphy.gif" align = "center" height = "650px">  
</p>  



```dart  
AdaptiveShimmer(  
//pass any widget you want to shimmer as a child of AdaptiveShimmer,  
//other properties like colors,loop,period,direction etc... are customisable  
child: child,  
//set loading to true to turn on shimmer & false to turn off shimmer (typically to represent when data/something is loading or not)  
loading: true,  
// baseColor: Colors.grey[300]!,  
// highlightColor: Colors.grey[100]!,  
// enabled: true,  
// period:  const Duration(milliseconds: 1500),  
// direction:ShimmerDirection.ltr,  
// loop: 0,  
);  
  
```  

## Additional information

Based on package shimmer: