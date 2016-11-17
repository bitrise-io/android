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
