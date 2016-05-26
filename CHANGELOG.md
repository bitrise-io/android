## 2016_05_26_1

* "Checkpoint", before migration to `ubuntu:16.04`
* Based on `bitriseio/docker-bitrise-base:2016_05_14_1`


## 2016_04_09_1

* `fastlane` pre-installed

## 2016_03_17_1

* Restructured `Dockerfile` (Android package install related codes), to fix
  Android package install license acceptance issues.
* `system_report.sh` now tests whether `adb` is available, prints it's version
  and lists the content of `platform-tools`, to check whether the platform-tools
  package was installed correctly

## 2016_03_11_1

* `android-N` and `build-tools-24.0.0-preview` packages pre-installed

## 2016_01_09_1

* `build-tools-23.0.1` is now pre-installed
