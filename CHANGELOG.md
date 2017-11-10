## UPCOMING

## `v2017_11_10_2`

* Rollback of `system-images;android-26;google_apis;x86` package preinstall;
  it seems this package has a dependency on a newer `emulator`, if the package is installed the emulator
  package version will be bumped to `26.1.4` from `26.1.2` ...

## `v2017_11_10_1`

* Rollback of `tools` package preinstall due to ARM v7 emulator boot issue.

## `v2017_11_08_2`

* Rollback to the locked Emulator package version, as it was since `v2017_08_10_1`;
  unfortunately even the latest `emulator` package makes the related tests to fail (ARMv7 emulator fails to boot) ...

## `v2017_11_08_1`

* new preinstalled packages: `build-tools-27.0.1`: https://github.com/bitrise-docker/android/pull/134

## `v2017_11_07_1`

* new preinstalled packages: 
    * `system-images;android-26;google_apis;x86`
    * `emulator`
    * `tools`
* removed packages:
    * `platforms;android-10`
    * `system-images;android-21;default;armeabi-v7a`

## `v2017_10_27_1`

* new preinstalled packages: `platform-27`, `build-tools-27.0.0`: https://github.com/bitrise-docker/android/pull/130
    * Thanks [@koral--](https://github.com/koral--) for the PR!

## `v2017_10_11_1`

* fix android/sdkmanager license issues

## `v2017_10_06_1`

* new preinstalled package: `build-tools-26.0.2`: https://github.com/bitrise-docker/android/pull/122

## `v2017_09_20_1`

* SDK tools updated to 26.1.1 : https://github.com/bitrise-docker/android/pull/118

## `v2017_08_14_1`

* Minor pre-installed package cleanup / removal:
    * Build tools: `26.0.0` & `25.0.2` & `20.0.0`
    * `platforms;android-20`
    * `system-images` : `android-17` & `android-15`


## `v2017_08_10_1`

* Android Emulator package version locked (`26.1.2` / `4077558`) : https://github.com/bitrise-docker/android/pull/104
* Docker image layer optimizations : https://github.com/bitrise-docker/android/pull/105


## `v2017_07_26_1`

* new preinstalled package: `build-tools-26.0.1`: https://github.com/bitrise-docker/android/pull/100

## `v2017_07_13_1`

* SDK tools, Platform Tools and Emulator versions added to `system_report.sh` : https://github.com/bitrise-docker/android/pull/96
* new preinstalled package: `emulator`

## `v2017_07_12_1`

* SDK tools updated to 26.0.2 : https://github.com/bitrise-docker/android/pull/95

## `v2017_06_10_1`

* new preinstalled packages: `build-tools-26.0.0`, `platforms;android-26` : https://github.com/bitrise-docker/android/pull/88

## `v2017_05_10_1`

* new preinstalled package: `build-tools-25.0.3`: https://github.com/bitrise-docker/android/pull/83

## `v2017_03_14_1`

* SDK tools updated to 25.2.5
* And related, quite significant Dockerfile revision: https://github.com/bitrise-docker/android/pull/68
    * Thanks [@koral--](https://github.com/koral--) for the PR!


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
