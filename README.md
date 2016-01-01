# React Native KDB Binding


## Rationale

fast access to KDB file on android

## Setup

* Install Module

```bash
npm install --save-dev react-native-android-kdb
```

* `android/settings.gradle`

```gradle
...
include ':react-native-android-kdb'
project(':react-native-android-kdb').projectDir = new File(settingsDir, '../node_modules/react-native-android-kdb')
```

* `android/app/build.gradle`

```gradle
dependencies {
	...
	compile project(':react-native-android-kdb')
}
```

* register module (in MainActivity.java)

```java
...

import io.ksanaforge.kdb.*; <--- import 

public class MainActivity extends Activity implements DefaultHardwareBackBtnHandler {
	...
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mReactRootView = new ReactRootView(this);

        mReactInstanceManager = ReactInstanceManager.builder()
                .setApplication(getApplication())
                .setBundleAssetName("index.android.bundle")
                .setJSMainModuleName("index.android")
                .addPackage(new MainReactPackage())
                .addPackage(new KDBModule())           // <- add heree
                .setUseDeveloperSupport(BuildConfig.DEBUG)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();

        mReactRootView.startReactApplication(mReactInstanceManager, "YourProject", null);

        setContentView(mReactRootView);
    }	
}
```

## Usage

So, the first step involves copying your kdb db to the following folder

```
<ReactNativeRootFolder>/node_modules/react-native-android-kdb/src/main/assets/databases
```

Substitute `<ReactNativeRootFolder>` for the folder where your app resides, i.e. AwesomeProject.


## LICENSE

MIT