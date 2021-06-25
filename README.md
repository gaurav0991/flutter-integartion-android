# demotest

A new flutter module project.

## Getting Started
Steps to connect native android to flutter

- In build.gradle(app) file add this line
 implementation project(':flutter')

- In settings.gradle file add these lines :
setBinding(new Binding([gradle: this ]))
evaluate(new File(
       settingsDir.parentFile,
       'demotest/.android/include_flutter.groovy'
))
Where demotest means the flutter project name
 
- Create a aar file in flutter by navigating to 
flutter project > .android folder 
And then in terminal ./gradlew flutter:assembleDebug
 
- Then startActivity(FlutterActivity.createDefaultIntent(this))
This will attach the flutter screen to native code 


