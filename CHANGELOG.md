## `v2017_03_14_1`

* SDK tools updated to 25.2.5
* And related, quite significant Dockerfile revision: https://github.com/bitrise-docker/android/pull/68
    * Thanks @koral-- for the PR!


## `v2017_01_11_1`

* Pre-installed android packages cleanup: https://github.com/bitrise-docker/android/pull/55/files


## `v2017_01_05_1`

* preinstall `ionic` and `cordova` npm packages (CLIs)
* `QT_QPA_PLATFORM` & `LD_LIBRARY_PATH` env vars set by default, for Android Emulator


## `v2016_12_19_1`

* Upgraded Android tools to `r25.2.4`
* Pre-installed `libqt5widgets5` for Android Emulator


## `v2016_12_15_1`

* new preinstalled package: `build-tools-25.0.2`


## `v2016_12_13_1`

* package `extra-android-support` removed - it's no longer available


## `v2016_11_23_1`

* new preinstalled package: `build-tools-25.0.1`


## `v2016_11_22_1`

* Google Cloud SDK is now preinstalled - thanks [@bootstraponline](https://github.com/bootstraponline) for the [PR](https://github.com/bitrise-docker/android/pull/36)!


## `v2016_11_17_1`

* removed `sys-img-armeabi-v7a-android-23` - it seems this Android package was removed from the registry


## `v2016_10_20_1`

* new preinstalled packages: `android-25` & `build-tools-25.0.0`


## `v2016_07_21_1`

* new preinstalled packages: `build-tools-24.0.1` & `sys-img-armeabi-v7a-android-24`


## `2016_06_18_1`

* `android-24` is no longer preview - package names were changed


## `2016_05_29_1`

* Install `Gradle` from official APT repo, instead of from a PPA
* Install `Maven` from official APT repo, instead of from a PPA
* Java (OpenJDK) upgrade from 7 to 8


## `2016_05_26_1`

* "Checkpoint", before migration to `ubuntu:16.04`
* Based on `bitriseio/docker-bitrise-base:2016_05_14_1`


## `2016_04_09_1`

* `fastlane` pre-installed

## `2016_03_17_1`

* Restructured `Dockerfile` (Android package install related codes), to fix
  Android package install license acceptance issues.
* `system_report.sh` now tests whether `adb` is available, prints it's version
  and lists the content of `platform-tools`, to check whether the platform-tools
  package was installed correctly

## `2016_03_11_1`

* `android-N` and `build-tools-24.0.0-preview` packages pre-installed

## `2016_01_09_1`

* `build-tools-23.0.1` is now pre-installed
